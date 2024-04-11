#!/bin/bash

# Usage: ./quickedit.sh [popup|window]
# Opens fzf to select a filetype, and opens /tmp/edit{filetype} in nvim inside of a tmux [popup|window].
# After exiting nvim, the file contents get put in the tmux clipboard and the file gets deleted.

print_help() {
	echo "Usage: ./quickedit.sh [popup|window]"
	echo "Opens fzf to select a filetype, and opens /tmp/edit{filetype} in nvim inside of a tmux [popup|window]."
    echo "After exiting nvim, the file contents get put in the tmux clipboard and the file gets deleted."
}

if [ "$1" == "popup" ]; then
	type_of_window="popup -E"
elif [ "$1" == "window" ]; then
	type_of_window="new-window"
else
	print_help
    exit
fi

declare -A filetypes

filetypes["Markdown"]=".md"
filetypes["Text"]=".txt"
filetypes["Cpp"]=".cpp"
filetypes["Python"]=".py"

selected_filetype=${filetypes[$(printf '%s\n' "${!filetypes[@]}" | fzf-tmux)]}

file="/tmp/edit$selected_filetype"

touch "$file"

tmux $type_of_window nvim $file

cat $file | tmux load-buffer -
rm $file
