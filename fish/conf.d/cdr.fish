set -x ANYFFF__CDR_CACHE_PATH ~/.cache/fish
if not test -d $ANYFFF__CDR_CACHE_PATH
  mkdir -p $ANYFFF__CDR_CACHE_PATH
end

set -x ANYFFF__CDR_HISTORIES_FILE cdr.log
set -x ANYFFF__CDR_HISTORIES_MARK '-'
set -x ANYFFF__CDR_HISTORIES_PATH "$ANYFFF__CDR_CACHE_PATH/$ANYFFF__CDR_HISTORIES_FILE"
if not test -e $ANYFFF__CDR_HISTORIES_PATH
  touch $ANYFFF__CDR_HISTORIES_PATH
end

set -x ANYFFF__CDR_SIBLINGS_FILE (printf "/tmp/siblings_dirs.%s" %self)
set -x ANYFFF__CDR_SIBLINGS_MARK ':'
if not test -e $ANYFFF__CDR_SIBLINGS_FILE
  touch $ANYFFF__CDR_SIBLINGS_FILE
end

set -x ANYFFF__CDR_BRANCHES_FILE (printf "/tmp/branches_dirs.%s" %self)
set -x ANYFFF__CDR_BRANCHES_MARK '>'
if not test -e $ANYFFF__CDR_BRANCHES_FILE
  touch $ANYFFF__CDR_BRANCHES_FILE
end

set -x ANYFFF__CDR_ROOT_FILE (printf "/tmp/root_dirs.%s" %self)
set -x ANYFFF__CDR_ROOT_MARK '<'
if not test -e $ANYFFF__CDR_ROOT_FILE
  touch $ANYFFF__CDR_ROOT_FILE
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
  pwd >> $ANYFFF__CDR_HISTORIES_PATH
  cat $ANYFFF__CDR_HISTORIES_PATH \
    | __reverse \
    | __unique \
    | __reverse \
    > $ANYFFF__CDR_HISTORIES_PATH
end

function __siblings_dirs
  find ../. -type d -depth 1 \
    | xargs realpath \
    > $ANYFFF__CDR_SIBLINGS_FILE
end

function __branches_dirs
  find . -type d -depth 1 \
    | xargs realpath \
    > $ANYFFF__CDR_BRANCHES_FILE
end

function __root_dirs
  echo '/' > $ANYFFF__CDR_ROOT_FILE
  pwd \
    | string split '/' \
    | sed 1,1d \
    | awk '{v=sprintf("%s/%s", v, $0); print v;}' \
    >> $ANYFFF__CDR_ROOT_FILE
end

function __cdr_source
  begin
    cat $ANYFFF__CDR_HISTORIES_PATH \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_HISTORIES_MARK \
      | __reverse
    cat $ANYFFF__CDR_SIBLINGS_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_SIBLINGS_MARK \
      | __reverse
    cat $ANYFFF__CDR_BRANCHES_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_BRANCHES_MARK \
      | __reverse
    cat $ANYFFF__CDR_ROOT_FILE \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_ROOT_MARK \
      | __reverse
  end
end

function __cdr_selected_item_cleanup
  cut -c3-
end
