export LANG=ja_JP.UTF-8
export EDITOR=nvim
export XDG_CONFIG_HOME=~/.config
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export BROWSER=vivaldi

# emacs keybind
bindkey -e

# ヒストリー設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory             # .zsh_historyへの書き込みは上書きではなく追記
setopt hist_ignore_all_dups      # 重複したとき、古い履歴を削除
setopt hist_ignore_space         # 先頭にスペースを入れると履歴を保存しない
setopt share_history             # 履歴を共有する

# ディレクトリ
setopt autopushd            # 自動でpushdする
setopt chase_links          # リンクへ移動するとき実際のディレクトリへ移動
setopt pushd_ignore_dups    # 重複するディレクトリは記憶しない

# auto cd
setopt auto_cd

setopt extended_glob

# zmv enable
autoload -Uz zmv

# export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1
export SKIM_DEFAULT_OPTIONS='--ansi -c rg'
export FUZZY_FINDER_APP=sk

# less colorize / [required] sudo apt install -y source-highlight
if type "source-highlight" > /dev/null 2>&1; then
  export LESS='-R'
  export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
fi

alias ll='ls -l'
alias la='ls -al'

# for git diff
# export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# linuxbrew
export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
export XDG_DATA_DIRS="/home/hagiyat/.linuxbrew/share:$XDG_DATA_DIRS"
export PKG_CONFIG_PATH="$HOME/.linuxbrew/lib/pkgconfig"

# git-remoteのURLをhttpsに変換してopenする
function git-browse() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    $BROWSER `git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||'`
  else
    echo ".git not found.\n"
  fi
}

# 略語展開
typeset -A abbreviations
abbreviations=(
  # vim
  "v" "nvim"
  "vd" "nvim -d"
  "vrc" "nvim -c \"VimShellInteractive rails console --split=''\""
  "vrs" "nvim -c \"VimShellInteractive rails server --split=''\""
  # pipe
  "lf"   "| fzy"
  "lvi"  "| nvim -Rc 'set ft=zsh' -"
  "lsin"  "| xargs cat | nvim -Rc 'set ft=zsh' -"
  "lg" "| ag"
  # git
  "g"  "git status"
  "gs"  "git stash"
  "gb"  "git branch"
  "gbb"  "git checkout -b"
  "gd"  "git diff --word-diff"
  "gch"  "git checkout"
  "gcl"  "git clean -df -n"
  "gco"  "git commit -v"
  "ga"  "git add"
  "gl"  "git log"
  "gls"  "git log --stat"
  "glg"  "git log --stat --graph --oneline --decorate"
  "glm"  "git log --stat --author=hagiyat"
  "gps"  "git push"
  "gpl"  "git pull"
  "gbf"  "git checkout -b feature/"
  "gbh"  "git checkout -b hotfix/"
  "gbr"  "git-browse"
  # tmux
  "tmv"  "tmux split-window -v -c '#{pane_current_path}'"
  "tmh"  "tmux split-window -h -c '#{pane_current_path}'"
  "tmw"  "tmux new-window -c '#{pane_current_path}'"
  # rails
  "rs" "bin/rails server"
  "rc" "bin/rails console"
  # "rg" "rails generate"
  "rgm" "bin/rails generate migration"
  "rr" "bin/rails runner"
  "rsp" "bin/rspec"
  # bundle exec
  "be" "bundle exec"
  "bi" "bundle install --jobs=4 --path=vendor/bundle"
  "bu" "bundle update"
  "br" "bundle exec rake"
  "bm" "bundle exec rake db:migrate"
  # docker
  "d" "docker"
  "dc" "docker-compose"
  # other
  "b" "chromium" # firefox
  "qq" "exit"
)

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
  zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

# emacs-mac
if [ -d /Applications/Emacs.app/ ] ; then
  alias spacemacs="open -a /Applications/Emacs.app"
fi

# asdf
if [ -d $HOME/.asdf ] ; then
  . ~/.asdf/asdf.sh
fi

# direnv
eval "$(direnv hook zsh)"

# pip upgrade all packages
alias pip-update='pip list --outdated | awk '{print $1}' | xargs pip install -U'

# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end

if type sk > /dev/null; then
  export SKIM_DEFAULT_OPTIONS='--ansi -c rg'
fi

if type fzf > /dev/null; then
  export FZF_DEFAULT_OPTS='
    --height 40% --reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
  '
fi

# plugins
export ZPLUG_HOME=$HOME/.linuxbrew/opt/zplug
if [[ ! -d $ZPLUG_HOME ]]; then
  curl -sL --proto-redir -all,https https://zplug.sh/installer | zsh
  zplug update --self
fi
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/cd-gitroot"
zplug "plugins/git", from:oh-my-zsh
zplug "mollifier/anyframe"

# completions
zplug "zsh-users/zsh-completions"
zplug "docker/compose", as:command, use:"contrib/completion/zsh/_docker-compose"
zplug "docker/docker", as:command, use:"contrib/completion/zsh/_docker"

# uses colortheme for iTerm2 `hybrid`
# ls color
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
if [ -x "`which dircolors`" ]; then
  # brew install coreutils
  # zplug "joel-porquet/zsh-dircolors-solarized", hook-load:"setupsolarized dircolors.ansi-universal"
  alias ls="ls --color=auto"
else
  alias ls="ls -G"
fi
alias grep="grep --color=auto"

# ctags for ruby
function rtags() {
  if [ -e Gemfile -a -e Gemfile.lock ]; then
    ctags --tag-relative=yes \
      -R --sort=yes --languages=ruby \
      --exclude=.git --exclude=log --exclude=tmp . \
      $(bundle list --paths | rg -v bundler)
    if [ $? -eq 0 ]; then
      echo "Generated!"
    else
      echo "tags generate to failed.."
      return 1
    fi
  else
    echo "Here is not from the Ruby project."
    return 1
  fi
}

# theme
autoload colors && colors
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "hagiyat/hyperzsh", at:customize, use:hyperzsh.zsh-theme, defer:2

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

if zplug check "b4b4r07/enhancd"; then
  ENHANCD_FILTER=fzf:fzy:sk
  export ENHANCD_FILTER
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

if zplug check "mollifier/anyframe"; then
  local filter_app=fzf
  # zle redisplayしないと表示がおかしくなるので、anyframeで完結できない。。
  function put_history() {
    anyframe-source-history \
      | $filter_app --prompt "history > " \
      | anyframe-action-put
    zle redisplay
  }
  zle -N put_history

  function insert_git_branch() {
    anyframe-source-git-branch -i \
      | $filter_app --prompt "insert branch > " \
      | awk '{print $1}' \
      | anyframe-action-insert
    zle redisplay
  }
  zle -N insert_git_branch

  function checkout_git_branch() {
    anyframe-source-git-branch -n \
      | $filter_app --prompt "checkout branch > " \
      | awk '{print $1}' \
      | anyframe-action-execute git checkout
    zle redisplay
  }
  zle -N checkout_git_branch

  function insert_filename() {
    rg --files \
      | $filter_app --prompt "file > " \
      | anyframe-action-insert -q
    zle redisplay
  }
  zle -N insert_filename

  function kill_process() {
    anyframe-source-process \
      | $filter_app --prompt "kill process > " \
      | awk '{print $1}' \
      | anyframe-action-execute kill -9
    zle redisplay
  }
  zle -N kill_process

  bindkey '^r' put_history
  bindkey '^x^i' insert_git_branch
  bindkey '^x^b' checkout_git_branch
  bindkey '^x^f' insert_filename
  bindkey '^x^p' kill_process
fi

# zplug load --verbose
zplug load

# awscli completions
[ -f /usr/local/share/zsh/site-functions/_aws ] && source /usr/local/share/zsh/site-functions/_aws
if [ -d $HOME/.asdf ] ; then
  source ~/.asdf/completions/asdf.bash
fi
# linuxbrew completions
if [ -d $HOME/.linuxbrew ]; then
  source $HOME/.linuxbrew/share/zsh/site-functions
fi
