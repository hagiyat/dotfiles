autoload -Uz promptinit
promptinit
prompt powerline

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

# auto cd
setopt auto_cd

# zmv enable
autoload -Uz zmv
#alias zmv='noglob zmv -W'

export TERM=xterm-256color

alias tmux="LD_LIBRARY_PATH=/usr/local/lib /usr/local/bin/tmux"

alias ll='ls -l'
alias la='ls -al'

alias git-delete-merged-branches="git branch --merged | grep -v '*' | xargs -I % git branch -d %"
alias phpl="php -l"
alias vdiff="vimdiff +VimdiffBootstrap"

#alias tag_update="tmux split-window -v -l 1 -c '#{pane_current_path}' \"echo 'tag updating...';gtags --gtagslabel=pygments;ctags -f tags -R;ctags -R -f Gemfile.lock.tags `bundle show --paths`\""
function update_tags {
  #gtags --gtagslabel=pygments & \
  ctags -f tags -R & \
  ctags -R -f Gemfile.lock.tags `bundle show --paths` & \
  echo 'tag updating...'
}

# 略語展開
setopt extended_glob
typeset -A abberviations
abberviations=(
  # vim
  "v" "vim"
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
  "gd"  "git diff"
  "gch"  "git checkout"
  "gco"  "git commit -v"
  "ga"  "git add"
  "gl"  "git log"
  "gls"  "git log --stat"
  "glg"  "git log --stat --graph"
  "glm"  "git log --stat --author=hagiya"
  "gps"  "git push"
  "gpl"  "git pull"
  "gbf"  "git checkout -b feature/"
  "gbh"  "git checkout -b hotfix/"
  "gbr"  "git-browse"
  "gbrp" "git-browse-with-peco"
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
  "bi" "bundle install --jobs=4"
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
)

magic-abbrev-expand() {
  local MATCH
  LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9]#}
  LBUFFER+=${abberviations[$MATCH]:-$MATCH}
  zle self-insert
}

no-magic-abbrev-expand() {
  LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N no-magic-abbrev-expand
bindkey " " magic-abbrev-expand
bindkey "^x " no-magic-abbrev-expand

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

# tmuxのバッファをvimで開く
alias tmuxvim="tmux capture-pane -S -2000\; show-buffer | vim +2000 -Rc 'set ft=zsh' -"

# agで検索した結果をvimで開く
function agvim() {
  if [ $# -eq 1 ]; then
    ag $1 --noheading | vim -Rc 'set ft=zsh' -
  else
    echo "Usage: age QUERY"
  fi
}

# 現在のブランチの分岐点からのdiff
function diff-branch() {
  git show-branch --sha1-name  master `git symbolic-ref --short HEAD` | tail -1 | grep -Eo '[a-z0-9]+' | head -1 | pbcopy
  git diff --stat=200,150 `pbpaste` HEAD
}

# コマンドラインのシンタックスハイライト
# http://blog.glidenote.com/blog/2012/12/15/zsh-syntax-highlighting/
if [ -f ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# 範囲選択
if [ -f ~/.zsh/selection.zsh ]; then
  source ~/.zsh/selection.zsh
fi

# git-remoteのURLをhttpsに変換してopenする
function git-browse() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    open `git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||'`
  else
    echo ".git not found.\n"
  fi
}
function git-browse-with-peco() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    local uri="$(git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||')"
    local branch="$(peco-select-branche | awk '{if ($0 ~ "master"); else print "tree/" $0}')"
    open "$uri/$branch"
  else
    echo ".git not found.\n"
  fi
}

# peco!!
if [ -x `which peco` > /dev/null 2>&1 ]; then
  alias peco='peco --rcfile ~/.peco/config.json'
  function _peco() {
    peco --rcfile ~/.peco/config.json $1
  }
  function _peco_single() {
    peco --rcfile ~/.peco/config_single.json $1
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
  bindkey '^[[25~d' peco-cdr

  # peco版履歴検索
  function exists_command { which $1 &> /dev/null }
  function peco-select-history() {
    BUFFER=$(fc -l -n 1 | tail -r | LC_ALL=C sed -e '/^cd/d' | _peco_single --prompt='[history]')
    CURSOR=$#BUFFER   # 履歴を呼び出すだけならこっち
    #zle accept-line  # 即実行するならこっち
  }
  zle -N peco-select-history
  bindkey '^r' peco-select-history

  # originのブランチをひとつ選択する
  function peco-select-branche() {
    git rev-parse --git-dir >/dev/null 2>&1
    if [[ $? == 0 ]]; then
      git for-each-ref --format='%(refname)' --sort=-committerdate refs/remotes refs/tags | sed -e 's|^refs/||' -e 's|^remotes/origin/||' | _peco_single --prompt='[branches]'
    fi
  }

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
  bindkey '^[[25~g' peco-git-branches

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
    # if [[ ! -z `cat /etc/hosts | grep nanapi` ]]; then
    #   networksetup -connectpppoeservice "nanapi"
    # fi
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

  function nanapi-vpn() {
    tmux split-window -v -l 1 "if [[ ! -z `networksetup -showpppoestatus nanapi | grep disconnected` ]]; then networksetup -connectpppoeservice nanapi; fi;"
  }

  function codic() {
    TARG=$(cat ~/.vim/bundle/codic-vim/dict/naming-entry.csv | peco --prompt="[codic]" --initial-matcher="Migemo" | awk -F , '{print $1}')
    if [ $? = 1 -o "$TARG" = "" ]; then
      echo "no pattern was matched"
      return 1
    fi
    cat ~/.vim/bundle/codic-vim/dict/naming-translation.csv | grep "$TARG" | awk -F , '{print "parts: " $3; print "mean: " $4; print "note: " $5 "\n";}'
  }

  function peco-ssh-aws() {
    local host=$(gsed -ne '/### EC2SSH BEGIN ###/,$p' ~/.ssh/config | gsed -ne '/^Host /p' | gsed 's/^Host //g' | _peco_single --prompt="[AWS]")
    if [[ -n $host ]]; then
      BUFFER="ssh hagiya@$host"
      CURSOR=$#BUFFER
    fi
  }
  zle -N peco-ssh-aws
  bindkey '^[c' peco-ssh-aws
  bindkey '^[[25~c' peco-ssh-aws
fi

