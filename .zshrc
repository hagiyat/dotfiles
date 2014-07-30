#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Customize to your needs...

export LANG=ja_JP.UTF-8
export EDITOR=vim
#export PAGER=vimpager
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/.go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

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

# antigen!!
#source ~/.zsh/antigen.conf

# auto cd
setopt auto_cd

#export TERM=xterm-256color

alias tmux="LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/tmux"

alias ll='ls -l'
alias la='ls -al'

# git alias
alias gits="git status"
#alias gitd="git difftool --tool=vimdiff --no-prompt"
alias gitd="git diff"
alias gitco="git checkout"
alias gita="git add"
alias gitl="git log"
alias gitls="git log --stat"
alias gitlg="git log --stat --graph"
alias gitlm="git log --stat --author=hagiya"
alias git-delete-merged-branches="git branch --merged | grep -v '*' | xargs -I % git branch -d %"

alias phpl="php -l"
alias vdiff="vimdiff +VimdiffBootstrap"

# 便利系
function agcount() { ag $1 | wc -l | tr -d " "; }

if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# cdrを有効化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# peco!!
if [ -x `which peco` > /dev/null 2>&1 ]; then
  alias peco='peco --rcfile ~/.peco/config.json'
  function _peco() {
    peco --rcfile ~/.peco/config.json $1
  }
  function _peco_single() {
    peco --rcfile ~/.peco/config_single.json $1
  }
  # Ag + peco + vim
  function age() {
    if [ $# -eq 1 ]; then
      #local files="$(ag --noheading $1 | sed '/^$/d' | _peco | awk -F":" '{print "+" $2 " " $1}' | tr '\n' ' ')"
      #vim "$(ag --noheading $1 | sed '/^$/d' | _peco | awk -F":" '{print "+" $2 " " $1}' | tr '\n' ' ')"
      ag --noheading $1 | sed '/^$/d' | _peco | awk -F":" '{print $1}' | xargs -o $EDITOR
    else
      echo "Usage: age QUERY"
    fi
  }

  # Ag + peco + pbcopy
  function agp() {
    if [ $# -eq 1 ]; then
      ag $1 | _peco --prompt="[pbcopy]" | awk {'$1="";print'} | pbcopy
    else
      echo "Usage: agp QUERY"
    fi
  }

  # peco版cdr
  # search a destination from cdr list and cd the destination
  function peco-cdr() {
    local destination="$(cdr -l | sed -e 's/^[[:digit:]]*[[:blank:]]*//' | _peco_single --prompt='[cdr]')"
    if [ -n "$destination" ]; then
      BUFFER="cd $destination && ls -al"
      zle accept-line
    else
      zle reset-prompt
    fi
  }
  zle -N peco-cdr
  bindkey '^[d' peco-cdr

  # peco版履歴検索
  function exists_command { which $1 &> /dev/null }
  function peco-select-history() {
    BUFFER=$(fc -l -n 1 | tail -r | LC_ALL=C sed -e '/^cd/d' | _peco_single --prompt='[history]')
    CURSOR=$#BUFFER   # 履歴を呼び出すだけならこっち
    #zle accept-line  # 即実行するならこっち
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  #peco版git-branches
  function peco-git-branches () {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
      #local branches_list="$(git show-ref | awk ' $2 != "refs/stash" { print $2 }' | sed -e '/^stash/d' | sed -e 's/refs\///g' | _peco_single)"
      local branches_list="$(git for-each-ref --format='%(refname)' --sort=-committerdate refs/heads refs/remotes refs/tags | sed -e 's/^refs\///g' | _peco_single --prompt='[branches]')"
      local b_type=${branches_list%%/*}
      local b_name=${branches_list#(heads|remotes|tags)/}
      case "$b_type" in
        "heads"|"tags")
          BUFFER="git checkout $b_name"
          zle accept-line
          ;;
        "remotes")
          BUFFER="git checkout -t $b_name"
          zle accept-line
          ;;
      esac
    fi
  }
  zle -N peco-git-branches
  bindkey '^[g' peco-git-branches

  # git addをGUIツールっぽくする
  alias pgitadd="git status -s | sed -e '/^[^ |\?]/d' | _peco --prompt='[git add]' | awk '{print \$2}' | xargs git add"

  # リッチなgit diffしたいときに
 function peco-git-diff() {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
      #git diff --stat $1 | _peco_single | awk '{print $1}' | xargs -o vim -c "Gdiff $1|colorscheme hybrid|set background=dark"
      local target=$(git diff --stat $1 | _peco_single --prompt='[git diff]' | awk '{print $1}')
      if [[ -n $target ]]; then
        vimdiff <(git show $1:$target) $target
      fi
    fi
  }

  # 選んでkillしたい
  alias peco-kill="ps aux | _peco --prompt='[pkill]' | awk '{print \$2}' | xargs kill"

  # hosts変更/複数選んだらくっつける
  function change_hosts() {
    sudo -v && ls /etc/hosts.* | sed -e '/equiv$/d' | _peco --prompt='[hosts]' | xargs cat | sort | uniq | sudo tee /etc/hosts
    if [[ ! -z `cat /etc/hosts | grep nanapi` ]]; then
      networksetup -connectpppoeservice "nanapi"
    fi
  }

  # カレントディレクトリのファイルリスト
  # ここからパイプしてxargsでrmとか
  alias pfiles="ag -l ./ | _peco"
  function peco-search-file() {
    ${1:=$(pwd)}
    local selected=$(find $1 -maxdepth 2 | _peco_single)
    if [[ -d $selected ]]; then
      peco-search-file $selected
    elif [[ -f $selected ]]; then
      cat $selected
    fi
  }

  alias nanapi-vpn="if [[ ! -z `networksetup -showpppoestatus nanapi | grep disconnected` ]]; then networksetup -connectpppoeservice nanapi; fi;"

  function codic() {
    TARG=$(cat ~/.vim/bundle/codic-vim/dict/naming-entry.csv | peco --prompt="[codic]" | awk -F , '{print $1}')
    if [ $? = 1 -o "$TARG" = "" ]; then
      echo "no pattern was matched"
      return 1
    fi
    cat ~/.vim/bundle/codic-vim/dict/naming-translation.csv | grep "$TARG" | awk -F , '{print "parts: " $3; print "mean: " $4; print "note: " $5 "\n";}'
  }

fi

