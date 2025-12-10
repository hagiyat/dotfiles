#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Manjaro/Arch Linux Setup Script
# Run directly: bash <(curl -sL https://raw.githubusercontent.com/hagiyat/dotfiles/main/manjaro_setup.sh)
# =============================================================================

DOTFILES_REPO="https://github.com/hagiyat/dotfiles.git"
DOTFILES_DIR="$HOME/dotfiles"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[OK]${NC} $1"; }
log_warning() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

# =============================================================================
# Package Lists (embedded)
# =============================================================================
OFFICIAL_PACKAGES=(
  # CLI Tools
  bat
  btop
  eza
  fd
  fzf
  ripgrep
  htop
  lazygit
  direnv

  # Git Tools
  git-delta
  difftastic

  # Language Runtimes & Version Managers
  deno
  pyenv
  ruby

  # Lua Development
  stylua
  luacheck
  luarocks

  # Python Packages
  python-pipx
  python-pynvim
  python-dotenv
  python-prompt_toolkit
  python-tiktoken

  # Japanese Input (fcitx5)
  fcitx5
  fcitx5-mozc
  fcitx5-configtool
  fcitx5-gtk
  fcitx5-material-color
  fcitx5-nord

  # Fonts (Nerd Fonts)
  ttf-jetbrains-mono-nerd
  ttf-hack
  ttf-meslo-nerd-font-powerlevel10k
  ttf-cascadia-code-nerd
  ttf-0xproto-nerd
  ttf-mononoki-nerd
  otf-geist-mono-nerd
  otf-commit-mono-nerd

  # Japanese Fonts
  adobe-source-han-sans-jp-fonts
  adobe-source-han-serif-jp-fonts

  # Applications
  bitwarden
  brave-browser
  chromium
  gimp
  steam
  onlyoffice-desktopeditors
)

AUR_PACKAGES=(
  # Terminal
  wezterm-nightly-bin

  # Version Managers
  fnm-bin

  # Fonts
  adobe-source-han-mono-jp-fonts

  # Browsers
  zen-browser-bin

  # Applications
  spotify

  # GNOME Extensions
  gnome-shell-extension-material-shell
  gnome-shell-extension-x11gestures
)

# =============================================================================
# Symlink Configuration
# =============================================================================
declare -A SYMLINKS=(
  ["$HOME/.config/nvim"]="nvim"
  ["$HOME/.config/bat"]="bat"
  ["$HOME/.gitconfig"]="gitconfig"
  ["$HOME/.config/git/ignore"]="gitignore_global"
  ["$HOME/.vimrc"]="vimrc"
  ["$HOME/.zshrc"]="zshrc"
  ["$HOME/.zshenv"]="zshenv.sample"
  ["$HOME/.config/wezterm"]="wezterm"
  ["$HOME/.config/fontconfig"]="fontconfig"
  ["$HOME/.config/pmy"]="pmy"
)

# =============================================================================
# Helper Functions
# =============================================================================
check_command() {
  command -v "$1" &> /dev/null
}

# =============================================================================
# Package Installation
# =============================================================================
install_yay() {
  if check_command yay; then
    log_success "yay is already installed"
    return 0
  fi

  log_info "Installing yay (AUR helper)..."
  sudo pacman -S --needed --noconfirm base-devel git

  local tmp_dir
  tmp_dir=$(mktemp -d)
  git clone https://aur.archlinux.org/yay.git "$tmp_dir/yay"
  cd "$tmp_dir/yay"
  makepkg -si --noconfirm
  cd -
  rm -rf "$tmp_dir"

  log_success "yay installed successfully"
}

install_official_packages() {
  log_info "Installing official repository packages..."

  if [[ ${#OFFICIAL_PACKAGES[@]} -eq 0 ]]; then
    log_warning "No official packages defined"
    return 0
  fi

  sudo pacman -S --needed --noconfirm "${OFFICIAL_PACKAGES[@]}"

  log_success "Official packages installed"
}

install_aur_packages() {
  if ! check_command yay; then
    log_error "yay is not installed, cannot install AUR packages"
    return 1
  fi

  log_info "Installing AUR packages..."

  if [[ ${#AUR_PACKAGES[@]} -eq 0 ]]; then
    log_warning "No AUR packages defined"
    return 0
  fi

  yay -S --needed --noconfirm "${AUR_PACKAGES[@]}"

  log_success "AUR packages installed"
}

# =============================================================================
# Dotfiles Setup
# =============================================================================
clone_dotfiles() {
  if [[ -d "$DOTFILES_DIR" ]]; then
    log_success "Dotfiles directory already exists: $DOTFILES_DIR"
    cd "$DOTFILES_DIR"
    git pull --ff-only || log_warning "Could not update dotfiles"
    return 0
  fi

  log_info "Cloning dotfiles repository..."
  git clone "$DOTFILES_REPO" "$DOTFILES_DIR"
  log_success "Dotfiles cloned to $DOTFILES_DIR"
}

setup_symlinks() {
  log_info "Setting up symlinks..."

  if [[ ! -d "$DOTFILES_DIR" ]]; then
    log_error "Dotfiles directory not found: $DOTFILES_DIR"
    return 1
  fi

  for dest in "${!SYMLINKS[@]}"; do
    local source="${SYMLINKS[$dest]}"
    local source_path="$DOTFILES_DIR/$source"
    local dest_dir
    dest_dir=$(dirname "$dest")

    # Check if source exists
    if [[ ! -e "$source_path" ]]; then
      log_warning "[skip] Source not found: $source_path"
      continue
    fi

    # Create parent directory if needed
    if [[ ! -d "$dest_dir" ]]; then
      mkdir -p "$dest_dir"
      log_info "Created directory: $dest_dir"
    fi

    if [[ -L "$dest" ]]; then
      log_success "[exists] $dest"
    elif [[ -e "$dest" ]]; then
      log_warning "[backup] $dest -> ${dest}.backup"
      mv "$dest" "${dest}.backup"
      ln -s "$source_path" "$dest"
      log_success "[created] $dest"
    else
      ln -s "$source_path" "$dest"
      log_success "[created] $dest"
    fi
  done
}

# =============================================================================
# Post-install Setup
# =============================================================================
setup_fnm() {
  if ! check_command fnm; then
    log_warning "fnm not installed, skipping Node.js setup"
    return 0
  fi

  log_info "Setting up fnm (Node.js version manager)..."

  # Install latest LTS Node.js if not already installed
  if ! fnm list 2>/dev/null | grep -q "lts"; then
    fnm install --lts
    fnm default lts-latest
    log_success "Node.js LTS installed via fnm"
  else
    log_success "Node.js LTS already installed"
  fi
}

# =============================================================================
# Main
# =============================================================================
usage() {
  cat << EOF
Usage: $(basename "$0") [COMMAND]

Commands:
  all         Run full setup (default)
  packages    Install packages only
  dotfiles    Clone dotfiles and setup symlinks only
  fnm         Setup fnm and install Node.js
  help        Show this help message

Run directly from the web:
  bash <(curl -sL https://raw.githubusercontent.com/hagiyat/dotfiles/main/manjaro_setup.sh)

Examples:
  $(basename "$0")           # Run full setup
  $(basename "$0") packages  # Install packages only
  $(basename "$0") dotfiles  # Setup symlinks only
EOF
}

main() {
  local command="${1:-all}"

  case "$command" in
    all)
      log_info "Starting full setup..."
      install_yay
      install_official_packages
      install_aur_packages
      clone_dotfiles
      setup_symlinks
      setup_fnm
      log_success "Setup completed!"
      log_info "Please edit ~/.zshenv to set GITHUB_API_TOKEN and other personal settings"
      ;;
    packages)
      install_yay
      install_official_packages
      install_aur_packages
      ;;
    dotfiles)
      clone_dotfiles
      setup_symlinks
      ;;
    fnm)
      setup_fnm
      ;;
    help|--help|-h)
      usage
      ;;
    *)
      log_error "Unknown command: $command"
      usage
      exit 1
      ;;
  esac
}

main "$@"
