#!/usr/bin/bash

# Usage: get_all_files_by_name.sh [pattern] [destination]
# Copies all files whose path contains pattern to destination

print_help() {
	echo "Usage: get_all_files_by_name.sh [pattern] [destination]"
	echo "Copies all files whose path contains pattern to destination"
}

# Used by script runner
if [ $# -ne 2 ] && [ "$1" == "--list-args" ]; then
	echo "pattern destination"
	exit
fi

if [ $# -ne 2 ]; then
	test
	print_help
	exit
fi

OLD_IFS=$IFS
IFS=$'\n'

i=1
for file_with_path in $(find | grep "$1"); do
	filename=$(basename "$file_with_path")
	cp "$file_with_path" "$2/$i-$filename"
	i=$(($i + 1))
done

IFS=$OLD_IFS
echo "Copied $(($i - 1)) files to $2"
