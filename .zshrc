alias ll='ls -alt'

export PATH=/usr/local/bin:$PATH
export LANG=ja_JP.UTF-8

autoload -U compinit && compinit

# ヒストリー設定
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups     # ignore duplication command history list
setopt share_history

# コマンド履歴検索
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

# 移動したディレクトリを記録しておく。"cd -[Tab]"で移動履歴を一覧
setopt auto_pushd

# コマンド訂正
setopt correct

# 補完
#source ~/.zsh/plugin/incr*.zsh
source ~/.zsh/plugin/git-completion.bash
source ~/.zsh/plugin/git-flow-completion.bash
fpath=(/usr/local/share/zsh-completions $fpath)
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' '+m:{A-Z}={a-z}'

autoload -Uz add-zsh-hook
autoload -U colors
colors
autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}[%s %b] %{'$reset_color'%}'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"    # 適当な文字列に変更する
zstyle ':vcs_info:git:*' unstagedstr "-"  # 適当の文字列に変更する
zstyle ':vcs_info:git:*' formats '(%s)-[%b] %c%u'
zstyle ':vcs_info:git:*' actionformats '(%s)-[%b|%a] %c%u'

# 右プロンプト
function _update_vcs_info_msg() {
	psvar=()
	LANG=en_US.UTF-8 vcs_info
	[[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
add-zsh-hook precmd _update_vcs_info_msg
RPROMPT="%1(v|%F{green}%1v%f|)"

# 左プロンプト
setopt prompt_subst
precmd () {
	LANG=en_US.UTF-8 vcs_info
	PROMPT='%{${fg[yellow]}%} %/ %%%{$reset_color%}
% > '
}

