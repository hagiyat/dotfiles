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
    "gd, git diff --word-diff" \
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
