#!/bin/bash

declare -A commands

commands["Change brighteness"]="brighteness"
commands["Change volume"]="vol"
commands["Cht.sh"]="chtsh"
commands["Lock"]="lock"

selected=${commands[$(printf '%s\n' "${!commands[@]}" | rofi -dmenu -i -p "")]}

case "$selected" in
"vol")
	current_volume=$(pactl get-sink-volume @DEFAULT_SINK@ | cut -d "/" -f2 | head -n1 | tr -d " ")
	new_volume=$(echo "" | rofi -dmenu -theme-str 'listview {enabled: false;}' -i -p "Enter volume percentage(current is $current_volume)")
	pactl set-sink-volume @DEFAULT_SINK@ "$new_volume%"
	;;
"brighteness")
	current_brightness=$(brightnessctl -m | awk -F, '{print $4}')
	new_brightness=$(echo "" | rofi -dmenu -theme-str 'listview {enabled: false;}' -i -p "Enter brightness percentage(current is $current_brightness)")
	brightnessctl s "$new_brightness%"
	;;
"lock")
	sleep 0.3
	i3lock -B 10 --indicator -k --time-color=FFFFFF --date-color=FFFFFF --time-str="%H:%M"
	;;
"chtsh")
	# TODO
	;;
esac
