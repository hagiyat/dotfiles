# デフォルトでは履歴がひとつのセッションでしか保存されないので、その対応
function sync_history --on-event fish_postexec
  history --save
  history --merge
end
