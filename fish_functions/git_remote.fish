# git-remoteのURLをhttpsに変換
function git_remote_uri
  command git config --get remote.origin.url | sed -e 's|\:|/|' -e 's|^git@|https://|' -e 's|.git$||'
end

# git-remoteのURIをブラウザで開く
function git-browse
  if git_is_repo
    command open (git_remote_uri)
  else
    printf ".git not found.\n"
  end
end
