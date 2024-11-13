#!/bin/bash


session="youtube"

# -d tells tmux not to attach to the session that is created
tmux new-session -d -s $session

# windows and panes index starting at 0, so this is the first window
window=0

# renaming a window can help with quickly seeing which window you want
# using the prefix-key combo (deafault ctrl+b), you can give numbers to access
# windows 0 through 9
tmux rename-window -t $session:$window "htop"

# C-m tells tmux to send the keys ctrl + m, which is the same as the enter key
tmux send-keys -t $session:$window "htop" C-m

window=1
tmux new-window -t $session:$window -n "log"

# tmux can split vertically with -v or horizontally with -h
tmux split-window -v -t $session:$window
tmux select-pane -t 0
tmux send-keys -t $session:$window "tail -F ~/backup/20241109.log" C-m
tmux select-pane -t 1
tmux send-keys -t $session:$winodw "ls" C-m

tmux select-window -t $session:0

tmux attach-session -t $session
