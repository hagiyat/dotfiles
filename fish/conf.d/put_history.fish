# fuzzy-finder
function __fuzzy_finder
  eval "$FUZZY_FINDER_APP -p '$argv'"
end

function put_history
  builtin history \
    | __fuzzy_finder "history > " \
    | read -l selected
  if [ $selected ]
    commandline $selected
  end
  commandline -f repaint
end

function insert_filename
  rg --files \
    | __fuzzy_finder "file > " \
    | read -l selected
  if [ $selected ]
    commandline -i $selected
    commandline -f repaint
  end
end

function checkout_git_branch
  if git_is_repo
    begin \
      git branch; \
      git branch -r | sed 1,2d | sed 's/^ *origin\//- /g'; \
    end \
    | __fuzzy_finder "checkout > " \
    | read -l selected

    if [ $selected ]
      set -l mark (echo $selected >| string sub -l 2 >| string trim)
      set -l branch (echo $selected >| string sub -s 2 >| string trim)
      switch $mark
        case '-'
          commandline "git checkout -b $branch"
        case ''
          commandline "git checkout $branch"
      end
    end
    commandline -f repaint
  else
    echo '.git?'
  end
end

function insert_git_branch
  if git_is_repo
    git branch \
      | __fuzzy_finder "branch > " \
      | awk '{print $NF}' \
      | read -l selected
    if [ $selected ]
      commandline -i $selected
      commandline -f repaint
    end
  else
    echo '.git?'
  end
end

function kill_process
  ps -u $USER -o pid,stat,%cpu,%mem,cputime,command \
    | sed 1,2d \
    | __fuzzy_finder "kill > " \
    | awk '{print $1}' \
    | read -l selected
  if [ $selected ]
    commandline "kill -9 $selected"
  end
end

function cdr_widget
  __cdr_source \
    | __fuzzy_finder "cd > " \
    | read -l selected
  if [ $selected ]
    builtin cd $selected
  end
end
