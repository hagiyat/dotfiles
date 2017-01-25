set -x LANG ja_JP.UTF-8
set -x EDITOR nvim
set -x XDG_CONFIG_HOME ~/.config
set -x TERM xterm-256color
set -x NVIM_TUI_ENABLE_TRUE_COLOR 1

if not test -d ~/repos
  mkdir -p ~/repos
end
set -g CDPATH . ~ ~/.config/ ~/repos

if type -q sk
  set -x SKIM_DEFAULT_OPTIONS '--ansi'
  set -x ANYFFF__FINDER_APP sk
  set -x ANYFFF__FINDER_APP_OPTION_MULTIPLE '-m'
end

# homebrew
set -U fish_user_paths /usr/local/bin
set -U fish_user_paths /usr/local/sbin $fish_user_paths

# for git diff
set -U fish_user_paths /usr/local/share/git-core/contrib/diff-highlight $fish_user_paths

# anyenv
if test -d "$HOME/.anyenv"
  set -U fish_user_paths $HOME/.anyenv/bin $fish_user_paths
  status --is-interactive; and source (anyenv init -| psub)
end

# direnv
eval (direnv hook fish)

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
