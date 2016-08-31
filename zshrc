export LANG=ja_JP.UTF-8
export EDITOR=vim
#export PAGER=vimpager

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

export TERM=xterm-256color

alias ll='ls -l'
alias la='ls -al'

# for git diff
export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight

# git-remoteのURLをhttpsに変換してopenする
function git-browse() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    open `git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||'`
  else
    echo ".git not found.\n"
  fi
}

# 略語展開
typeset -A abbreviations
abbreviations=(
  # vim
  "v" "vim"
  "nv" "nvim"
  "vrc" "vim -c \"VimShellInteractive rails console --split=''\""
  "vrs" "vim -c \"VimShellInteractive rails server --split=''\""
  # pipe
  "lps"  "| peco --rcfile ~/.peco/config_single.json"
  "lp"   "| peco"
  "lvi"  "| vim -Rc 'set ft=zsh' -"
  "lsin"  "| xargs cat | vim -Rc 'set ft=zsh' -"
  "lg" "| ag"
  # git
  "g"  "git status"
  "gs"  "git stash"
  "gb"  "git branch"
  "gbb"  "git checkout -b"
  "gd"  "git diff"
  "gch"  "git checkout"
  "gco"  "git commit -v"
  "ga"  "git add"
  "gl"  "git log"
  "gls"  "git log --stat"
  "glg"  "git log --stat --graph --oneline --decorate"
  "glm"  "git log --stat --author=hagiya"
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
  "rs" "rails server"
  "rc" "rails console"
  "rg" "rails generate"
  "rgm" "rails generate migration"
  "rr" "rails runner"
  # bundle exec
  "be" "bundle exec"
  "bi" "bundle install --jobs=4 --path=vendor/bundle"
  "bu" "bundle update"
  "br" "bundle exec rake"
  "bm" "bundle exec rake db:migrate"
  # rbenv
  "rer" "rbenv rehash"
  # dash
  "dru" "open dash://ruby:"
  "dra" "open dash://rails:"
  "drs" "open dash://rspec:"
  "dmy" "open dash://mysql:"
  "da"  "open dash://"
  # docker
  "d" "docker"
  "dc" "docker-compose"
  # other
  "b" "browse"
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

# openコマンドでfile uri schemeをブラウザで開く(markdown preview用)
# if [ -d /Applications/Google\ Chrome.app/ ] ; then
#   alias browse="open -a /Applications/Google\ Chrome.app"
# fi
if [ -d /Applications/Firefox.app/ ] ; then
  alias browse="open -a /Applications/Firefox.app"
fi

# anyenv
if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# direnv
eval "$(direnv hook zsh)"


# plugins
if [[ ! -d ~/.zplug ]]; then
  curl -sL zplug.sh/installer | zsh
  zplug update --self
fi
source ~/.zplug/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-history-substring-search"
zplug "b4b4r07/enhancd", use:init.sh
zplug "mollifier/cd-gitroot"
zplug "plugins/git", from:oh-my-zsh
zplug "mollifier/anyframe"

# completions
zplug "zsh-users/zsh-completions"
zplug "felixr/docker-zsh-completion"

# uses colortheme for iTerm2 `hybrid`
# ls color
export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
if [ -x "`which dircolors`" ]; then
  # brew install coreutils
  zplug "joel-porquet/zsh-dircolors-solarized", hook-load:"setupsolarized dircolors.ansi-universal"
  alias ls="ls --color=auto"
else
  # export LSCOLORS=xbfxcxdxbxegedabagacad
  alias ls="ls -G"
fi
alias grep="grep --color=auto"

# theme
autoload colors && colors
setopt prompt_subst # Make sure propt is able to be generated properly.
zplug "hagiyat/hyperzsh", at:customize, use:hyperzsh.zsh-theme, nice:11

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

if zplug check "zsh-users/zsh-history-substring-search"; then
  bindkey '^P' history-substring-search-up
  bindkey '^N' history-substring-search-down
fi

if zplug check "mollifier/anyframe"; then
  bindkey '^r' anyframe-widget-put-history
  bindkey '^xi' anyframe-widget-insert-git-branch
  bindkey '^x^i' anyframe-widget-insert-git-branch
  bindkey '^xc' anyframe-widget-checkout-git-branch
  bindkey '^x^c' anyframe-widget-checkout-git-branch
  bindkey '^x^x' anyframe-widget-checkout-git-branch
  bindkey '^x^f' anyframe-widget-insert-filename
fi

zplug load --verbose

