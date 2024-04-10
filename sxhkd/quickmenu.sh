#!/bin/bash

declare -A commands

commands["Change brighteness"]="brighteness"
commands["Change volume"]="vol"
commands["Cht.sh"]="chtsh"

selected=${commands[$(printf '%s\n' "${!commands[@]}" | rofi -dmenu -i -p "")]}

case "$selected" in 
    "vol")
        echo "volume" | rofi -dmenu 
        ;;
    "brighteness")
	    brightnessctl s $(echo "" | rofi -dmenu -theme-str 'listview {enabled: false;}' -i -p "Enter brightness percentage(current is $(brightnessctl -m  | awk -F, '{print $4}'))")%
        ;;
    "chtsh")
        echo "cht" | rofi -dmenu
        ;;
esac
