#!/bin/sh
tmux capture-pane -S -2000\; show-buffer > /tmp/tmuxcap_`date +"%Y%m%d%H%M%S"`.txt
