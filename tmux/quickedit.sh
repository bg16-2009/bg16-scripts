#!/bin/bash

declare -A filetypes

filetypes["Markdown"]=".md"
filetypes["Text"]=".txt"
filetypes["Cpp"]=".cpp"
filetypes["Python"]=".py"

selected_filetype=${filetypes[$(printf '%s\n' "${!filetypes[@]}" | fzf)]}

file="/tmp/edit$selected_filetype"

touch "$file"

nvim $file
cat $file | tmux load-buffer -
rm $file
