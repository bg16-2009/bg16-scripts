#!/bin/bash

declare -A filetypes

filetypes["Markdown"]=".md"
filetypes["Text"]=".txt"
filetypes["Cpp"]=".cpp"
filetypes["Python"]=".py"

selected_filetype=${filetypes[$(printf '%s\n' "${!filetypes[@]}" | fzf-tmux)]}

file="/tmp/edit$selected_filetype"

touch "$file"

if [ "$1" == "popup" ]; then
	tmux popup -E nvim $file
fi
if [ "$1" == "window" ]; then
	tmux new-window nvim $file
fi
cat $file | tmux load-buffer -
rm $file
