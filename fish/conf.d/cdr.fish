set -x CDR_CACHE_PATH ~/.cache/fish
if not test -d $CDR_CACHE_PATH
  mkdir -p $CDR_CACHE_PATH
end

set -x CDR_HISTORIES_FILE cdr.log
set -x CDR_HISTORIES_PATH "$CDR_CACHE_PATH/$CDR_HISTORIES_FILE"
if not test -e $CDR_HISTORIES_PATH
  touch $CDR_HISTORIES_PATH
end

function __register_cdr --on-variable PWD
  __append_cd_history &
  __sibling_dirs &
  __parent_dirs &
end

function __append_cd_history
  set -l escaped_pwd (string replace -a '/' '\/' (pwd))
  # osx only
  cat $CDR_HISTORIES_PATH \
    | sed -E "/^$escaped_pwd/d" \
    > $CDR_HISTORIES_PATH
  pwd >> $CDR_HISTORIES_PATH
end

function __sibling_dirs
  set -l filename (printf '/tmp/sibling_dirs.%s' %self)
  find . -type d -depth 1 \
    | sed '/\.git/d' \
    | awk "NR > 1 { sub(\"./\", \"$PWD/\"); print; }" \
    > $filename
end

function __parent_dirs
  set -l filename (printf '/tmp/parent_dirs.%s' %self)
  echo '/' > $filename
  pwd \
    | string split '/' \
    | sed 1,1d \
    | awk '{v=sprintf("%s/%s", v, $0); print v;}' \
    >> $filename
end

function __cdr_source
  begin
    cat $CDR_HISTORIES_PATH
    cat (printf '/tmp/sibling_dirs.%s' %self)
    cat (printf '/tmp/parent_dirs.%s' %self)
  end
end
