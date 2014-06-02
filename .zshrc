alias ll='ls -l'
alias la='ls -al'
export LANG=ja_JP.UTF-8

# ヒストリー設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt appendhistory             # HISTFILEを上書きせずに追記
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
setopt autopushd            # 自動でpushdする。cd -[tab]で候補表示
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
#alias ssh='TERM=xterm-256color ssh'

#/usr/bin/keychain $HOME/.ssh/id_rsa
#source $HOME/.keychain/$HOST-sh

alias tmux="LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/tmux"

# z
#. `brew --prefix`/etc/profile.d/z.sh
#function precmd () {
#   z --add "$(pwd -P)"
#}
#alias j="z"


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
alias gitf="git flow"

alias phpl="php -l"


if [ -d ${HOME}/.anyenv ] ; then
  export PATH="$HOME/.anyenv/bin:$PATH"
  eval "$(anyenv init -)"
  for D in `ls $HOME/.anyenv/envs`
  do
    export PATH="$HOME/.anyenv/envs/$D/shims:$PATH"
  done
fi

# (zaw準備)cdrを有効化
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

# Ctrl-Rが過去実行コマンドの履歴検索、Ctrl-Sが過去にいたディレクトリの履歴検索
bindkey '^r' zaw-history

# zaw!!
source ~/.zsh/zaw/zaw.zsh

bindkey '^[d' zaw-cdr
bindkey '^[g' zaw-git-branches
bindkey '^[z' zaw-gitdir

function zaw-src-gitdir () {
  _dir=$(git rev-parse --show-cdup 2>/dev/null)
  if [ $? -eq 0 ]
  then
    candidates=( $(git ls-files ${_dir} | perl -MFile::Basename -nle \
                                               '$a{dirname $_}++; END{delete $a{"."}; print for sort keys %a}') )
  fi
  actions=("zaw-src-gitdir-cd")
  act_descriptions=("change directory in git repos")
}

function zaw-src-gitdir-cd () {
  BUFFER="cd $1"
  zle accept-line
}
zaw-register-src -n gitdir zaw-src-gitdir

# Ctrl-Rが過去実行コマンドの履歴検索、Ctrl-Sが過去にいたディレクトリの履歴検索
bindkey '^R' zaw-history

# percol!!
alias p='percol'

# history置き換え
#function percol-select-history() {
#    local tac
#    if which tac > /dev/null; then
#        tac="tac"
#    else
#        tac="tail -r"
#    fi
#    BUFFER=$(history -n 1 | \
#        eval $tac | \
#        percol --query "$LBUFFER")
#    CURSOR=$#BUFFER
#    zle clear-screen
#}
#zle -N percol-select-history
#bindkey '^r' percol-select-history

# ドキュメントインクリメンタルサーチ
function percol-search-document() {
    if [ $# -ge 1 ]; then
        DOCUMENT_DIR=$*
    else
        DOCUMENT_DIR=($HOME/Dropbox)
        if [ -d $HOME/Documents ]; then
            DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
        fi
    fi
    SELECTED_FILE=$(echo $DOCUMENT_DIR | \
        xargs find | \
        grep -E "\.(txt|md|pdf|key|numbers|pages|doc|xls|ppt)$" | \
        percol --match-method migemo)
    if [ $? -eq 0 ]; then
        echo $SELECTED_FILE | sed 's/ /\\ /g'
    fi
}
alias pd='percol-search-document'

# localteコマンドから結果を更に検索
function percol-search-locate() {
    if [ $# -ge 1 ]; then
        SELECTED_FILE=$(locate $* | percol --match-method migemo)
        if [ $? -eq 0 ]; then
            echo $SELECTED_FILE | sed 's/ /\\ /g'
        fi
    else
        bultin locate
    fi
}
alias psl='percol-search-locate'

