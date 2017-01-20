set -l ANYFFF__FINDER_COLLECTION fzy sk peco fzf percol
if not set -q ANYFFF__FINDER_APP
  for f in $ANYFFF__FINDER_COLLECTION
    if test -x $f
      set -x $ANYFFF__FINDER_APP $f
      break
    end
  end
end

function __fuzzy_finder
  eval "$ANYFFF__FINDER_APP -p '$argv'"
end

function put_history_widget
  builtin history \
    | __fuzzy_finder "history > " \
    | read -l selected
  if [ $selected ]
    commandline $selected
  end
  commandline -f repaint
end

function insert_filename_widget
  __context_file_extraction \
    | __fuzzy_finder "file > " \
    | __last_element \
    | read -l selected
  if [ $selected ]
    commandline -i $selected
    commandline -f repaint
  end
end

function checkout_git_branch_widget
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

function insert_git_branch_widget
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

function kill_process_widget
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
    | __fuzzy_finder "cd:$PWD > " \
    | __cdr_selected_item_cleanup \
    | read -l selected
  if [ $selected ]
    builtin cd $selected
  end
end
