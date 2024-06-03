#!/bin/sh

# Toggles the HDMI display

if xrandr --listmonitors | grep -q HDMI  ; then
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --off
else
    xrandr --output eDP-1 --primary --mode 1366x768 --pos 0x312 --rotate normal --output DP-1 --off --output HDMI-1 --off --output DP-2 --off --output HDMI-2 --mode 1920x1080 --pos 1366x0 --rotate normal
fi

nitrogen --restore
