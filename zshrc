export LANG=ja_JP.UTF-8
export LC_ALL=ja_JP.UTF-8
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/var/lib/flatpak/exports/share:$HOME/.local/share/flatpak/exports/share:/usr/local/share:/usr/share
# export XDG_DATA_DIRS=/usr/local/share:/usr/share
export BROWSER=chromium
export PROJECTS_HOME=$HOME/repos
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

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

# historyにコメントごと残すための設定
setopt interactive_comments

# zmv enable
autoload -Uz zmv

# compinit
autoload -Uz compinit; compinit

# export TERM=xterm-256color
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# less colorize / [required] sudo apt install -y source-highlight
if type "source-highlight" > /dev/null 2>&1; then
  export LESS='-R'
  # export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
  export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
fi

if [ ! -d $PROJECTS_HOME ]; then
  mkdir -p $PROJECTS_HOME
fi

if [ -x "`which exa`" ]; then
  alias Ll='ls -l'
  alias La='ls -al'
  alias ll='exa -l --git --time-style=long-iso'
  alias la='exa -al --time-style=long-iso'
  alias lt='exa -lT --git --time-style=long-iso'
  alias lta='exa -laT --time-style=long-iso'
else
  alias ll='ls -l'
  alias la='ls -al'
fi

if [ -x "`which pacui`" ]; then
  export PACUI_AUR_HELPER=yay
fi

# for git diff
# export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
export PATH=$PATH:/usr/share/git/diff-highlight

# git-remoteのURLをhttpsに変換してopenする
function git-browse() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    $BROWSER `git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||'`
  else
    echo ".git not found.\n"
  fi
}

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

if type fzf > /dev/null; then
  export FZF_DEFAULT_OPTS='--height 40% --reverse'
fi

# color test
alias colorchart='(x=`tput op` y=`printf %40s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)'

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


# plugins
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

zinit ice wait'0' lucid; zinit light "zsh-users/zsh-syntax-highlighting"
zinit ice wait'0' \
  atload'bindkey "^P" history-substring-search-up; bindkey "^N" history-substring-search-down' \
  lucid
zinit light "zsh-users/zsh-history-substring-search"
zinit ice wait'0' lucid; zinit load "zsh-users/zsh-autosuggestions"
zinit ice proto'git' pick'init.sh' atload'export ENHANCD_FILTER=fzf:fzy'
zinit light "b4b4r07/enhancd"
# zinit load "plugins/git", from:oh-my-zsh

# completions
zinit light "zsh-users/zsh-completions"
# zinit "docker/compose", as:command, use:"contrib/completion/zsh/_docker-compose"
# zinit "docker/docker", as:command, use:"contrib/completion/zsh/_docker"
#
# prompt configurations
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
if [[ -v INSIDE_EMACS ]]; then
  PURE_GIT_STASH_SYMBOL="👾"
  PURE_GIT_UP_ARROW="🚀"
  PURE_GIT_DOWN_ARROW="🌩"
  PURE_PROMPT_SYMBOL="➤"
else
  PURE_GIT_STASH_SYMBOL="🗊"
  PURE_GIT_UP_ARROW="🛪"
  PURE_GIT_DOWN_ARROW="🗱"
  # PURE_PROMPT_SYMBOL="⟖ ⪩"
  PURE_PROMPT_SYMBOL="⋆🞟🢖"
fi
zstyle :prompt:pure:git:stash show yes
autoload -Uz promptinit; promptinit
# prompt pure
# eval "$(starship init zsh)"

zinit ice wait'0' lucid; zinit light "mollifier/anyframe"
local filter_app=fzf
function put_history() {
  anyframe-source-history \
    | $filter_app --prompt="history > " \
    | anyframe-action-put
  zle redisplay
}
zle -N put_history

function insert_git_branch() {
  anyframe-source-git-branch -i \
    | $filter_app --prompt="insert branch > " \
    | awk '{print $1}' \
    | anyframe-action-insert
  zle redisplay
}
zle -N insert_git_branch

function switch_git_branch() {
  anyframe-source-git-branch -n \
    | $filter_app --prompt="switch branch > " \
    | awk '{print $1}' \
    | anyframe-action-execute git switch
  zle redisplay
}
zle -N switch_git_branch

function insert_filename() {
  rg --files \
    | $filter_app --prompt="file > " \
    | anyframe-action-insert -q
  zle redisplay
}
zle -N insert_filename

function insert_commit_hash() {
  git log --pretty=oneline \
    | $filter_app --prompt="insert commit hash > " \
    | awk '{print $1}' \
    | anyframe-action-insert
  zle redisplay
}
zle -N insert_commit_hash

function kill_process() {
  anyframe-source-process \
    | $filter_app --prompt="kill process > " \
    | awk '{print $1}' \
    | anyframe-action-execute kill -9
  zle redisplay
}
zle -N kill_process

bindkey '^r' put_history
bindkey '^x^i' insert_git_branch
bindkey '^x^b' switch_git_branch
bindkey '^x^h' insert_commit_hash
bindkey '^x^f' insert_filename
bindkey '^x^p' kill_process

# 略語展開
zinit ice wait'0' lucid atload'init_abbreviations'; zinit light "olets/zsh-abbr"
function init_abbreviations() {
  abbr --quiet v="nvim"
  abbr --quiet vd="nvim -d"

  abbr --quiet lf="| fzf"
  abbr --quiet lr="| rg"
  abbr --quiet lc="| xclip -selection c"

  abbr --quiet g="git status"
  abbr --quiet gst="git stash"
  abbr --quiet gsw="git switch"
  abbr --quiet gb="git branch"
  abbr --quiet gd="git diff"
  abbr --quiet gch="git checkout"
  abbr --quiet gcl="git clean -df -n"
  abbr --quiet gco="git commit -v"
  abbr --quiet ga="git add"
  abbr --quiet gl="git log"
  abbr --quiet glg="git log --stat --graph --oneline --decorate"
  abbr --quiet glm="git log --stat --author=hagiyat"
  abbr --quiet gps="git push"
  abbr --quiet gpf="git push --force-with-lease"
  abbr --quiet gpl="git pull"
  abbr --quiet gbf="git switch -c feature/"
  abbr --quiet gbh="git switch -c hotfix/"
  abbr --quiet gbr="git-browse"

  abbr --quiet tmv="tmux split-window -v -c '#{pane_current_path}'"
  abbr --quiet tmh="tmux split-window -h -c '#{pane_current_path}'"
  abbr --quiet tmw="tmux new-window -c '#{pane_current_path}'"

  abbr --quiet d="docker"
  abbr --quiet dc="docker-compose"
  abbr --quiet dce="docker-compose exec"

  abbr --quiet eh="$HOME/"
  abbr --quiet ec="$XDG_CONFIG_HOME/"
  abbr --quiet psa="ps auxwf"
  abbr --quiet xcp="xclip -selection c -o"
  abbr --quiet qq="exit"
}


# awscli completions
# [ -f /usr/local/share/zsh/site-functions/_aws ] && source /usr/local/share/zsh/site-functions/_aws
[ -f /usr/local/bin/aws_zsh_completer.sh ] && source /usr/local/bin/aws_zsh_completer.sh
[ -f /usr/bin/aws_zsh_completer.sh ] && source /usr/bin/aws_zsh_completer.sh

# asdf
if [ -d $HOME/.asdf ] ; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

if type yarn> /dev/null 2>&1; then
  export PATH="$PATH:`yarn global bin`"
fi

# zsh completions
if [ -e /etc/arch-release ]; then
  if [ -d /usr/share/zsh/site-functions ]; then
    source /usr/share/zsh/site-functions
  fi
fi
