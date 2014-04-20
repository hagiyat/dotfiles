alias ll='ls -l'
alias la='ls -al'

# gem installで追加したモジュールのパスを足した
export PATH=/usr/local/Celler/:$PATH
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
source ~/.zsh/zshrc.antigen

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

alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
    . `brew --prefix`/etc/autojump
fi

alias tmux="LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/tmux"

# git alias
alias gits="git status"
#alias gitd="git difftool --tool=vimdiff --no-prompt"
alias gitd="git diff"
alias gitl="git log"
alias gitls="git log --stat"
alias gitlg="git log --stat --graph"
alias gitlm="git log --stat --author=hagiya"
alias gitf="git flow"

export RBENV_ROOT="/usr/local/rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init -)"
