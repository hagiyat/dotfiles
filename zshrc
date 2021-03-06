export LANG=ja_JP.UTF-8
export EDITOR=nvim
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export XDG_DATA_HOME=$HOME/.local/share
export XDG_DATA_DIRS=/usr/local/share:/usr/share
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
  export FZF_DEFAULT_OPTS='
    --height 40% --reverse
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174
  '
fi

# color test
alias colorchart='(x=`tput op` y=`printf %40s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)'

# plugins
export ZPLUG_HOME=$HOME/.zplug
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
# zplug "momo-lab/zsh-abbrev-alias"

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
function _zplug_check_install() {
  if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
      echo; zplug install
    fi
  fi
}

if zplug check "b4b4r07/enhancd"; then
  ENHANCD_FILTER=fzf:fzy
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

  function insert_commit_hash() {
    git log --pretty=oneline \
      | $filter_app --prompt "insert commit hash > " \
      | awk '{print $1}' \
      | anyframe-action-insert
    zle redisplay
  }
  zle -N insert_commit_hash

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
  bindkey '^x^h' insert_commit_hash
  bindkey '^x^f' insert_filename
  bindkey '^x^p' kill_process
fi

# zplug load --verbose
zplug load

# 略語展開
# FIXME: global aliasを使わないプラグインを作るか、別ファイルに切り出すかする
typeset -Ag _abbrevs

__magic_abbrev_expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  local abbr=${_abbrevs[$MATCH]:-$MATCH}
  # local newbuffer=${abbr[2,-1]}
  LBUFFER+=$abbr
  zle self-insert
}

__no_magic_abbrev_expand() {
  LBUFFER+=' '
}

__abbrev_init() {
  setopt extended_glob
  zle -N __magic_abbrev_expand
  zle -N __no_magic_abbrev_expand
  bindkey " "   __magic_abbrev_expand
  bindkey "^x " __no_magic_abbrev_expand
}

__abbrev_regist() {
  local key=${1%%=*} value=${1#*=}
  _abbrevs[$key]="$value"
}

__abbrev_init

__abbrev_regist "v=nvim"
__abbrev_regist "vd=nvim -d"

__abbrev_regist "lf=| fzf"
__abbrev_regist "lr=| rg"
__abbrev_regist "lc=| xclip -selection c"

__abbrev_regist "g=git status"
__abbrev_regist "gs=git stash"
__abbrev_regist "gb=git branch"
__abbrev_regist "gd=git diff"
__abbrev_regist "gch=git checkout"
__abbrev_regist "gcl=git clean -df -n"
__abbrev_regist "gco=git commit -v"
__abbrev_regist "ga=git add"
__abbrev_regist "gl=git log"
__abbrev_regist "glg=git log --stat --graph --oneline --decorate"
__abbrev_regist "glm=git log --stat --author=hagiyat"
__abbrev_regist "gps=git push"
__abbrev_regist "gpf=git push --force-with-lease"
__abbrev_regist "gpl=git pull"
__abbrev_regist "gbf=git checkout -b feature/"
__abbrev_regist "gbh=git checkout -b hotfix/"
__abbrev_regist "gbr=git-browse"

__abbrev_regist "tmv=tmux split-window -v -c '#{pane_current_path}'"
__abbrev_regist "tmh=tmux split-window -h -c '#{pane_current_path}'"
__abbrev_regist "tmw=tmux new-window -c '#{pane_current_path}'"

__abbrev_regist "d=docker"
__abbrev_regist "dc=docker-compose"
__abbrev_regist "dce=docker-compose exec"

__abbrev_regist "eh=$HOME/"
__abbrev_regist "ec=$XDG_CONFIG_HOME/"
__abbrev_regist "psa=ps auxwf"
__abbrev_regist "xcp=xclip -selection c -o"
__abbrev_regist "qq=exit"

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

if (which zprof > /dev/null 2>&1) ;then
  zprof
fi
