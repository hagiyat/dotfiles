set -x CDR_CACHE_PATH ~/.cache/fish
if not test -d $CDR_CACHE_PATH
  mkdir -p $CDR_CACHE_PATH
end

set -x CDR_HISTORIES_FILE cdr.log
set -x CDR_HISTORIES_MARK '-'
set -x CDR_HISTORIES_PATH "$CDR_CACHE_PATH/$CDR_HISTORIES_FILE"
if not test -e $CDR_HISTORIES_PATH
  touch $CDR_HISTORIES_PATH
end

set -x CDR_SIBLINGS_FILE (printf "/tmp/siblings_dirs.%s" %self)
set -x CDR_SIBLINGS_MARK ':'
if not test -e $CDR_SIBLINGS_FILE
  touch $CDR_SIBLINGS_FILE
end

set -x CDR_BRANCHES_FILE (printf "/tmp/branches_dirs.%s" %self)
set -x CDR_BRANCHES_MARK '>'
if not test -e $CDR_BRANCHES_FILE
  touch $CDR_BRANCHES_FILE
end

set -x CDR_ROOT_FILE (printf "/tmp/root_dirs.%s" %self)
set -x CDR_ROOT_MARK '<'
if not test -e $CDR_ROOT_FILE
  touch $CDR_ROOT_FILE
end

function __filter_pwd
  awk -v pwd="$PWD" '$1!=pwd {print}'
end

function __add_cdr_type_mark
  sed -e "s/^/$argv /g"
end

function __register_cdr --on-variable PWD
  __append_cd_history &
  __siblings_dirs &
  __branches_dirs &
  __root_dirs &
end

function __reverse
  awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }'
end

function __unique
  awk '!colname[$1]++ {print}'
end

function __append_cd_history
  pwd >> $CDR_HISTORIES_PATH
  cat $CDR_HISTORIES_PATH \
    | __reverse \
    | __unique \
    | __reverse \
    > $CDR_HISTORIES_PATH
end

function __siblings_dirs
  find ../. -type d -depth 1 \
    | xargs realpath \
    > $CDR_SIBLINGS_FILE
end

function __branches_dirs
  find . -type d -depth 1 \
    | xargs realpath \
    > $CDR_BRANCHES_FILE
end

function __root_dirs
  echo '/' > $CDR_ROOT_FILE
  pwd \
    | string split '/' \
    | sed 1,1d \
    | awk '{v=sprintf("%s/%s", v, $0); print v;}' \
    >> $CDR_ROOT_FILE
end

function __cdr_source
  begin
    # cat $CDR_HISTORIES_PATH[1..(count $CDR_HISTORIES_PATH)] \
    cat $CDR_HISTORIES_PATH \
      | __filter_pwd \
      | __add_cdr_type_mark $CDR_HISTORIES_MARK \
      | __reverse
    cat $CDR_SIBLINGS_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $CDR_SIBLINGS_MARK \
      | __reverse
    cat $CDR_BRANCHES_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $CDR_BRANCHES_MARK \
      | __reverse
    cat $CDR_ROOT_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $CDR_ROOT_MARK \
      | __reverse
  end
end

function __cdr_selected_item_cleanup
  cut -c3-
end

