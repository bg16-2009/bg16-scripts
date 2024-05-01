#!/bin/bash

# Usage: ./sessionizer.sh
# Opens fzf to select a session from the ~/.config/tmux/sessions file.
# 
# The ~/.config/tmux/sessions file should look like this:
# ```
# {session_name} {session_path}
# {session_name} {session_path}
# {session_name} {session_path}
# ...
# {session_name} {session_path}
#
# If the session exists, it will be opened. 
# If the session doesn't exist, a new one will be created with the name {session name} in the {session path} directory
# After the session is created, the script ".tmux.sh" will be ran if it exists in the {session path} directory.
#
# The default .tmux.sh file is:
# ```
# tmux send-keys -t ":1" "nvim" Enter
# tmux send-keys -t ":1" ":Telescope find_files" Enter
# ```
#  WARNING:
#  This will not work if your tmux windows are numbered from 0.
#  For that, you will need to replace the ":1" with ":0"
#  or you can number them from 1 by adding 
#  ```
#  set -g base-index 1
#  setw -g pane-base-index 1
#  ```
#  to your tmux.conf
#

declare -A sessions

OLD_IFS=$IFS
IFS=$'\n'
for line in $(cat ~/.config/tmux/sessions); do
    sessions["$(echo $line | cut -d' ' -f1)"]="$(echo $line | cut -d' ' -f2)"
done
IFS=$OLD_IFS

session_name=$(printf '%s\n' "${!sessions[@]}" | fzf-tmux)
session_path=${sessions["$session_name"]}

if ! tmux has-session -t=$session_name 2>/dev/null; then
    tmux new-session -d -c $session_path -s $session_name
    if [ -f "$session_path/.tmux.sh" ]; then 
        tmux run-shell -c $session_path -b "$session_path/.tmux.sh"
    else
        tmux send-keys -t ":1" "nvim" Enter
        tmux send-keys -t ":1" ":Telescope find_files" Enter
    fi
fi

tmux switch-client -t $session_name
