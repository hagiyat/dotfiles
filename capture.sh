#!/bin/sh
tmux capture-pane -S -2000\; show-buffer > /tmp/tmuxcap_`date +"%Y%m%d%H%M%S"`.txt
tmux new-window -n "--history"
tmux set-option -t "--history" default-command "reattach-to-user-namespace -l zsh"
tmux send-keys -t:"--history" "ls -t /tmp/tmuxcap_*.txt | head -n 1 | xargs cat | vim +2000 -Rc 'set ft=zsh' - && exit" C-m
