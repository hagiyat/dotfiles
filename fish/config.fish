set -x LANG ja_JP.UTF-8
set -x EDITOR nvim
set -x XDG_CONFIG_HOME ~/.config
set -x TERM xterm-256color
set -x NVIM_TUI_ENABLE_TRUE_COLOR 1

# paths
begin
  # homebrew
  set -U fish_user_paths /usr/local/bin
  set -U fish_user_paths /usr/local/sbin $fish_user_paths

  # anyenv
  if test -d "$HOME/.anyenv"
    set -U fish_user_paths $HOME/.anyenv/bin $fish_user_paths
    status --is-interactive; and source (anyenv init - | psub)
  end

  # direnv
  eval (direnv hook fish)
end

# less colorize / [required] brew install source-highlight
if type -q source-highlight
  set -x LESS '-R'
  set -x LESSOPEN '| src-hilite-lesspipe.sh %s'
end

# pip
begin
  alias pip-update="pip list --outdated --format=columns | sed 1,2d | awk '{print $1}' | xargs pip install -U"

  # completion
  function __fish_complete_pip
      set -lx COMP_WORDS (commandline -o) ""
      set -lx COMP_CWORD (math (contains -i -- (commandline -t) $COMP_WORDS)-1)
      set -lx PIP_AUTO_COMPLETE 1
      string split \  -- (eval $COMP_WORDS[1])
  end
  complete -fa "(__fish_complete_pip)" -c pip
end

# fuzzy-finder
function put_history
  builtin history | fzy -p "histroy > " | read selected
  if [ $selected ]
    commandline $selected
  else
  end
end
bind \cr 'put_history'

# 略語展開
if status --is-interactive
  set -g fish_user_abbreviations
  set -l abbreviations \
    # vim
    "v, nvim" \
    "vd, nvim -d" \
    # git
    "g, git status" \
    "gs, git stash" \
    "gb, git branch" \
    "gbb, git checkout -b" \
    "gd, git diff" \
    "gch, git checkout" \
    "gco, git commit -v" \
    "ga, git add" \
    "gl, git log" \
    "gls, git log --stat" \
    "glg, git log --stat --graph --oneline --decorate" \
    "glm, git log --stat --author=hagiyat" \
    "gps, git push" \
    "gpl, git pull" \
    "gbf, git checkout -b feature/" \
    "gbh, git checkout -b hotfix/" \
    "gbr, git-browse" \
    # tmux
    "tmv, tmux split-window -v -c '#{pane_current_path}'" \
    "tmh, tmux split-window -h -c '#{pane_current_path}'" \
    "tmw, tmux new-window -c '#{pane_current_path}'" \
    # bundle exec
    "be, bundle exec" \
    "bi, bundle install --jobs=4 --path=vendor/bundle" \
    "bu, bundle update" \
    "br, bundle exec rake" \
    "bm, bundle exec rake db:migrate" \
    # rbenv
    "rer, rbenv rehash" \
    # docker
    "d, docker" \
    "dc, docker-compose" \
    # other
    "b, browse" \
    "qq, exit" \

  for _abbr in $abbreviations
    set -l abbr_pair (string split ", " $_abbr)
    abbr --add $abbr_pair[1] $abbr_pair[2]
  end
end

# emacs-mac
if test -d /Applications/Emacs.app/
  alias spacemacs "open -a /Applications/Emacs.app"
end

# openコマンドでfile uri schemeをブラウザで開く(markdown preview用)
begin
  if test -d "/Applications/Firefox.app"
    alias _firefox="open -a /Applications/Firefox.app"
  end
  # developer editionだとmarkdown preview動かない・・？
  if test -d "/Applications/FirefoxDeveloperEdition.app"
    alias firefox="open -a /Applications/FirefoxDeveloperEdition.app"
  end
  alias browse=_firefox
end
