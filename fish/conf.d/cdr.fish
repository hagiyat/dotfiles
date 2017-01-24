set -x ANYFFF__CDR_CACHE_PATH ~/.cache/fish/cdr
if not test -d $ANYFFF__CDR_CACHE_PATH
  mkdir -p $ANYFFF__CDR_CACHE_PATH
end

if test -x sha256sum
  set -x ANYFFF__CHECKSUM_APP 'sha256sum'
else
  set -x ANYFFF__CHECKSUM_APP 'shasum -a 256'
end

set -x ANYFFF__CDR_HISTORIES_FILE history.log
set -x ANYFFF__CDR_HISTORIES_PATH "$ANYFFF__CDR_CACHE_PATH/$ANYFFF__CDR_HISTORIES_FILE"
touch $ANYFFF__CDR_HISTORIES_PATH

# set -x ANYFFF__CDR_ACTIVITY_PATH "$ANYFFF__CDR_CACHE_PATH/activity.log"
if set -q ANYFFF__CDR_ACTIVITY_PATH
  touch $ANYFFF__CDR_ACTIVITY_PATH
end

set -x ANYFFF__CDR_HISTORIES_MARK '-'
set -x ANYFFF__CDR_SIBLINGS_MARK ':'
set -x ANYFFF__CDR_BRANCHES_MARK '>'
set -x ANYFFF__CDR_ROOT_MARK '<'

# 3days
set -x ANYFFF__CDR_CACHE_LIFETIME 3

function __filter_pwd
  awk -v pwd="$PWD" '$1!=pwd {print}'
end

function __add_cdr_type_mark
  sed -e "s/^/$argv /g"
end

function __get_checksum
  echo $argv | eval $ANYFFF__CHECKSUM_APP | __first_element
end

function __register_cdr --on-variable PWD
  __append_cd_history &
  __cache_directories (realpath "$PWD/..") &
  __cache_directories (realpath $PWD) &
  fish -c __clear_caches &
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

function __cache_directories --argument-names _dir
  set -l name_hash (__get_checksum $_dir)
  set -l dir_hash (__get_checksum (ls $_dir))
  set -l target_file (printf "%s/%s.log" $ANYFFF__CDR_CACHE_PATH $name_hash)

  if __is_match_checksum $dir_hash $target_file
    __push_activity_log "[found] $_dir -> $target_file"
  else
    __push_activity_log "[generate] $_dir -> $target_file"

    touch $target_file
    echo $dir_hash > $target_file
    find $_dir -type d -depth 1 -user $USER -perm -u+r ^/dev/null \
      | xargs realpath \
      >> $target_file
  end
end

function __push_activity_log --argument-names message
  if set -q ANYFFF__CDR_ACTIVITY_PATH
    echo $message >> $ANYFFF__CDR_ACTIVITY_PATH
  end
end

function __get_directories_from_cache --argument-names _dir
  set -l name_hash (__get_checksum $_dir)
  set -l dir_hash (__get_checksum (ls $_dir))
  set -l target_file (printf "%s/%s.log" $ANYFFF__CDR_CACHE_PATH $name_hash)

  if not __is_match_checksum $dir_hash $target_file
    __cache_directories $_dir
  end

  cat $target_file | sed 1,2d
end

function __is_match_checksum --argument-names dir_hash file_name
  if not test -e $file_name
    return 1
  end

  set -l hash_value (head -n 1 $file_name)
  return ([ $hash_value = $dir_hash ])
end

function __root_dirs
  echo '/'
  pwd \
    | string split '/' \
    | sed 1,1d \
    | awk '{v=sprintf("%s/%s", v, $0); print v;}'
end

function __clear_caches
  find $ANYFFF__CDR_CACHE_PATH -type f \
    -atime "+$ANYFFF__CDR_CACHE_LIFETIME" \
    ! -name $ANYFFF__CDR_HISTORIES_FILE \
    | xargs rm -f ^/dev/null
end

function force_clear_caches
  find $ANYFFF__CDR_CACHE_PATH -type f \
    ! -name $ANYFFF__CDR_HISTORIES_FILE \
    | xargs rm -f ^/dev/null
end

function __cdr_source
  begin
    cat $ANYFFF__CDR_HISTORIES_PATH \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_HISTORIES_MARK \
      | __reverse
    __get_directories_from_cache (realpath "$PWD/..") \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_SIBLINGS_MARK \
      | __reverse
    __get_directories_from_cache $PWD \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_BRANCHES_MARK \
      | __reverse
    __root_dirs \
      | __filter_pwd \
      | __add_cdr_type_mark $ANYFFF__CDR_ROOT_MARK \
      | __reverse
  end
end
