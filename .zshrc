alias ll='ls -l'
alias la='ls -al'
export LANG=ja_JP.UTF-8
export EDITOR=vim

# ヒストリー設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory             # .zsh_historyへの書き込みは上書きではなく追記
setopt hist_ignore_all_dups      # 重複したとき、古い履歴を削除
setopt hist_ignore_space         # 先頭にスペースを入れると履歴を保存しない
setopt share_history             # 履歴を共有する

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# ディレクトリ
setopt autopushd            # 自動でpushdする
setopt chase_links          # リンクへ移動するとき実際のディレクトリへ移動
setopt pushd_ignore_dups    # 重複するディレクトリは記憶しない

# コマンド訂正
setopt correct

# 補完
autoload -U compinit
compinit -u

# antigen!!
source ~/.zsh/antigen.conf

# auto cd
setopt auto_cd

zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

autoload -U colors
colors
autoload -Uz vcs_info

export TERM=xterm-256color

#/usr/bin/keychain $HOME/.ssh/id_rsa
#source $HOME/.keychain/$HOST-sh

alias tmux="LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/tmux"


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

# 表示領域を画面半分にする
zstyle ':filter-select' max-lines $(($LINES / 2))

# zaw!!
if [ -d ~/.zsh/zaw ]; then
  # (zaw準備)cdrを有効化
  #source ~/.zsh/zaw/zaw.zsh

  #bindkey '^[d' zaw-cdr
  #bindkey '^[g' zaw-git-branches

  # 履歴検索 / デフォルトのは潰してしまう
  #bindkey '^r' zaw-history
fi

# peco!!
if [ -x `which peco` > /dev/null 2>&1 ]; then
  alias P='peco'

  # Ag + peco + vim
  function age() {
    if [ $# -eq 1 ]; then
      ag --noheading $1 | peco | sed 's/^\(.*\):\(.*\):.*/\1 +\2/' | xargs -o $EDITOR
    else
      echo "Usage: age QUERY"
    fi
  }

  # Ag + paco + pbcopy
  function agp() {
    if [ $# -eq 1 ]; then
      ag $1 | peco | awk {'$1="";print'} | pbcopy
    else
      echo "Usage: agp QUERY"
    fi
  }

  # peco版cdr
  # search a destination from cdr list
  function peco-get-destination-from-cdr() {
    cdr -l | \
      sed -e 's/^[[:digit:]]*[[:blank:]]*//' | \
      peco --query "$LBUFFER"
  }

  # search a destination from cdr list and cd the destination
  function peco-cdr() {
    local destination="$(peco-get-destination-from-cdr)"
    if [ -n "$destination" ]; then
      BUFFER="cd $destination"
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
    BUFFER=$(fc -l -n 1 | tail -r | LC_ALL=C sed -e '/^cd/d' | peco --query "$LBUFFER")
    #CURSOR=$#BUFFER         # move cursor
    zle accept-line
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  #peco版git-branches
  function peco-git-branches () {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
      local branches_list="$(git show-ref | awk ' $2 != "refs/stash" { print $2 }' | sed -e '/^stash/d' | sed -e 's/refs\///g' | peco)"
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

  # オリジナル:git addで試してみる
  function peco-gitadd() {
    local selected=$(git status -s | awk {'print $2'} | peco)
    if [ -n "$selected" ]; then
      git add $selected
      git status
    fi
  }
fi

# auto-fu!!
#if [ -f ~/.zsh/auto-fu.zsh ]; then
#  source ~/.zsh/auto-fu.zsh/auto-fu.zsh
#  function zle-line-init () {
#      auto-fu-init
#  }
#  zle -N zle-line-init
#  # -azfu-を表示させない
#  zstyle ':auto-fu:var' postdisplay $''
#  zstyle ':completion:*' completer _oldlist _complete
#fi

# zawと相性悪い 非常に残念
#if [ -d ~/.zsh/zsh-autosuggestions ]; then
#  source ~/.zsh/zsh-autosuggestions/autosuggestions.zsh
#  # Enable autosuggestions automatically
#  zle-line-init() {
#    zle autosuggest-start
#  }
#  zle -N zle-line-init
#  bindkey '^[T' autosuggest-toggle
#  bindkey '^[F' autosuggest-accept-suggested-word
#fi

# ネットワーク系コマンド強制ギブス
#source ~/.zsh/gypsum.zsh

