#!/bin/bash

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
        tmux send-keys -t "$session_name:1" "nvim" Enter
        tmux send-keys -t "$session_name:1" ":Telescope find_files" Enter
    fi
fi

tmux switch-client -t $session_name
