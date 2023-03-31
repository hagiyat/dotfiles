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
# if [ -x "$(command -v source-highlight)" ]; then
  # export LESS='-R'
  # # export LESSOPEN='| /usr/share/source-highlight/src-hilite-lesspipe.sh %s'
  # export LESSOPEN='| /usr/bin/src-hilite-lesspipe.sh %s'
# fi

if [ ! -d $PROJECTS_HOME ]; then
  mkdir -p $PROJECTS_HOME
fi

if [ -x "$(command -v exa)" ]; then
  alias Ll='ls -l'
  alias La='ls -al'
  alias ll='exa -lh --git --time-style=long-iso --icons'
  alias la='exa -alh --time-style=long-iso --icons'
  alias lt='exa -lhT --git --time-style=long-iso --icons'
  alias lta='exa -lahT --time-style=long-iso --icons'
else
  alias ll='ls -l'
  alias la='ls -al'
fi

if [ -x "$(command -v pacui)" ]; then
  export PACUI_AUR_HELPER=yay
fi

# for git diff
# export PATH=$PATH:/usr/local/share/git-core/contrib/diff-highlight
path+=("/usr/share/git/diff-highlight")

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

if [ -x "$(command -v fzf)" ]; then
  export FZF_DEFAULT_OPTS='-0 -1 --ansi --height 40% --reverse'

  function put-history() {
    BUFFER=$(history -n -r 1 | awk '!a[$0]++' | fzf --no-sort --query "$LBUFFER" --prompt="histoy > ")
    CURSOR=$#BUFFER
    zle -R -c
    zle redisplay
  }
  zle -N put-history
  bindkey '^r' put-history
fi

# color test
alias colorchart='(x=`tput op` y=`printf %40s`;for i in {0..256};do o=00$i;echo -e ${o:${#o}-3:3} `tput setaf $i;tput setab $i`${y// /=}$x;done)'

# uses colortheme for iTerm2 `hybrid`
# ls color
# export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
if [ -x "$(command -v dircolors)" ]; then
  # brew install coreutils
  # zplug "joel-porquet/zsh-dircolors-solarized", hook-load:"setupsolarized dircolors.ansi-universal"
  alias ls="ls --color=auto"
else
  alias ls="ls -G"
fi
alias grep="grep --color=auto"


if [ -x "$(command -v bat)" ]; then
  # manに色付け
  export MANPAGER="sh -c 'col -bx | bat -l man -p'"
fi

# plugins
### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma-continuum/zinit.git "$HOME/.zinit/bin" && \
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

zinit ice wait'0' lucid; zinit light "zsh-users/zsh-history-substring-search"
zinit ice wait'0' lucid; zinit light "zsh-users/zsh-autosuggestions"

zinit ice wait'1' lucid pick'init.sh' atload'export ENHANCD_FILTER=fzf'
zinit light "b4b4r07/enhancd"

# completions
zinit ice wait'0' lucid; zinit light "zsh-users/zsh-completions"
#
# prompt configurations
zinit ice pick"async.zsh" src"pure.zsh"
zinit light sindresorhus/pure
PURE_GIT_STASH_SYMBOL="👾"
PURE_GIT_UP_ARROW="🚀"
PURE_GIT_DOWN_ARROW="📚"
if [[ -v INSIDE_EMACS ]]; then
  PURE_PROMPT_SYMBOL="➤"
else
  # PURE_GIT_STASH_SYMBOL="🗊"
  # PURE_GIT_UP_ARROW="🛪"
  # PURE_GIT_DOWN_ARROW="🗱"
  PURE_PROMPT_SYMBOL="💭"
  PURE_PROMPT_SYMBOL=" ﬌"
fi
zstyle :prompt:pure:git:stash show yes
autoload -Uz promptinit; promptinit
# prompt pure
# eval "$(starship init zsh)"

# 略語展開
zinit ice wait'0' lucid atload'init_abbreviations'; zinit light "momo-lab/zsh-abbrev-alias"
function init_abbreviations() {
  abbrev-alias -g v="nvim"
  abbrev-alias -g vd="nvim -d"

  abbrev-alias -g F="| fzf"
  abbrev-alias -g R="| rg"
  abbrev-alias -g C="| xclip -selection c"

  abbrev-alias -g g="git status"
  abbrev-alias -g gsh="git show"
  abbrev-alias -g gst="git stash"
  abbrev-alias -g gb="git branch"
  abbrev-alias -g gd="git diff"
  abbrev-alias -g gds="git diff --staged"
  abbrev-alias -g gch="git checkout"
  abbrev-alias -g gr="git restore"
  abbrev-alias -g grs="git restore --staged"
  abbrev-alias -g gcl="git clean -df -n"
  abbrev-alias -g gco="git commit -v"
  abbrev-alias -g ga="git add"
  abbrev-alias -g gl="git log"
  abbrev-alias -g glg="git log --stat --graph --oneline --decorate"
  abbrev-alias -g glm="git log --stat --author=hagiyat"
  abbrev-alias -g gps="git push"
  abbrev-alias -g gpf="git push --force-with-lease --force-if-includes"
  abbrev-alias -g gpl="git pull"
  abbrev-alias -g gs="git switch"
  abbrev-alias -g gsw="git switch -t"
  abbrev-alias -g gsc="git switch -c"
  abbrev-alias -g gbr="git-browse"

  abbrev-alias -g tms="tmux split-window -v -c '#{pane_current_path}'"
  abbrev-alias -g tmss="tmux split-window -v -c '#{pane_current_path}' -p 30"
  abbrev-alias -g tmv="tmux split-window -h -c '#{pane_current_path}'"
  abbrev-alias -g tmw="tmux new-window -c '#{pane_current_path}'"

  abbrev-alias -g d="docker"
  abbrev-alias -g dc="docker compose"
  abbrev-alias -g dce="docker compose exec"
  abbrev-alias -g dcu="docker compose up"

  abbrev-alias -g tf="terraform"

  abbrev-alias -g eh="$HOME/"
  abbrev-alias -g ec="$XDG_CONFIG_HOME/"
  abbrev-alias -g psa="ps auxwf"
  abbrev-alias -g md="mkdir -p"
  abbrev-alias -ge CO="$(xclip -selection c -o)"
  abbrev-alias -g ep="$HOME/repos" # project home
  abbrev-alias -g cdp="cd $HOME/repos"
  abbrev-alias -g qq="exit"
}

function init_pmy() {
  export PMY_TRIGGER_KEY="^[[Z" # shift + tab
  export PMY_RULE_PATH="$XDG_CONFIG_HOME/pmy/rules"
  export PMY_SNIPPET_PATH="$XDG_CONFIG_HOME/pmy/snippets"
  export PMY_LOG_PATH="$XDG_CACHE_HOME/pmy/log.txt"

  eval "$(pmy init)"
}
zinit ice lucid wait"0" as"program" from"gh-r" \
    pick"pmy*/pmy" \
    atload'init_pmy'
zinit light 'relastle/pmy'


[ -f /usr/local/bin/aws_zsh_completer.sh ] && source /usr/local/bin/aws_zsh_completer.sh
[ -f /usr/bin/aws_zsh_completer.sh ] && source /usr/bin/aws_zsh_completer.sh

# asdf
if [ -d /opt/asdf-vm ] ; then
  . /opt/asdf-vm/asdf.sh
elif [ -d $HOME/.asdf ] ; then
  . $HOME/.asdf/asdf.sh
  . $HOME/.asdf/completions/asdf.bash
fi

if [ -x "$(command -v yarn)" ]; then
  path+=(`yarn global bin`)
fi

# zsh completions
if [ -e /etc/arch-release ]; then
  if [ -d /usr/share/zsh/site-functions ]; then
    source /usr/share/zsh/site-functions
  fi
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/.local/bin/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/.local/bin/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/.local/bin/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/.local/bin/google-cloud-sdk/completion.zsh.inc"; fi
