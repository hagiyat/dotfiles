# デフォルトでは履歴がひとつのセッションでしか保存されないので、その対応
function sync_history --on-event fish_preexec
  history --save
  history --merge
end
