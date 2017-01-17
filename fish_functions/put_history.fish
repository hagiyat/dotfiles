# fuzzy-finder
function put_history
  builtin history | fzy -p "histroy > " | read -l selected
  if [ $selected ]
    commandline $selected
  end
  commandline -f repaint
end
