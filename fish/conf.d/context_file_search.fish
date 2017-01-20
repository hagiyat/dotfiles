if not set -q ANYFFF__FILESEARCH_MAXDEPTH
  set -x ANYFFF__FILESEARCH_MAXDEPTH 2
end

function __last_element
  awk '{print $NF}'
end

function __belongs_to_tracked_file
  set -l conditions 'git +add' 'git +checkout' 'git +reset'
  echo $argv | read -l cmd
  for c in $conditions
    if string match -q -r $c $cmd
      return 0
    end
  end
  return 1
end

function __context_file_extraction
  commandline | read -l cl
  if git_is_repo and string match -q 'git' $cl
    if __belongs_to_tracked_file $cl
      git status --short
    else
      git ls-files
    end
  else
    find . -maxdepth $ANYFFF__FILESEARCH_MAXDEPTH -type f \
      | cut -c3-
  end
end
