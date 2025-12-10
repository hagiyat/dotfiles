#!/usr/bin/env bash
set -euo pipefail

# =============================================================================
# Manjaro/Arch Linux Setup Script
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGES_FILE="$SCRIPT_DIR/packages.conf"
AUR_PACKAGES_FILE="$SCRIPT_DIR/packages-aur.conf"

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
parse_packages() {
  local file="$1"
  if [[ ! -f "$file" ]]; then
    log_error "Package file not found: $file"
    return 1
  fi
  grep -v '^\s*#' "$file" | grep -v '^\s*$' | awk '{print $1}'
}

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
  cd "$SCRIPT_DIR"
  rm -rf "$tmp_dir"

  log_success "yay installed successfully"
}

install_official_packages() {
  log_info "Installing official repository packages..."

  local packages
  packages=$(parse_packages "$PACKAGES_FILE")

  if [[ -z "$packages" ]]; then
    log_warning "No packages found in $PACKAGES_FILE"
    return 0
  fi

  # Filter out yay (installed separately)
  packages=$(echo "$packages" | grep -v '^yay$')

  echo "$packages" | xargs sudo pacman -S --needed --noconfirm

  log_success "Official packages installed"
}

install_aur_packages() {
  if [[ ! -f "$AUR_PACKAGES_FILE" ]]; then
    log_warning "AUR package file not found: $AUR_PACKAGES_FILE"
    return 0
  fi

  log_info "Installing AUR packages..."

  local packages
  packages=$(parse_packages "$AUR_PACKAGES_FILE")

  if [[ -z "$packages" ]]; then
    log_warning "No AUR packages found"
    return 0
  fi

  echo "$packages" | xargs yay -S --needed --noconfirm

  log_success "AUR packages installed"
}

# =============================================================================
# Dotfiles Setup
# =============================================================================
setup_symlinks() {
  log_info "Setting up symlinks..."

  for dest in "${!SYMLINKS[@]}"; do
    local source="${SYMLINKS[$dest]}"
    local source_path="$SCRIPT_DIR/$source"
    local dest_dir
    dest_dir=$(dirname "$dest")

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
  if ! fnm list | grep -q "lts"; then
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
  dotfiles    Setup dotfiles symlinks only
  fnm         Setup fnm and install Node.js
  help        Show this help message

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
      setup_symlinks
      setup_fnm
      log_success "Setup completed!"
      ;;
    packages)
      install_yay
      install_official_packages
      install_aur_packages
      ;;
    dotfiles)
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
