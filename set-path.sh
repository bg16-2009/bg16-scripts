#!/usr/bin/bash

scripts_dir=$(dirname "$BASH_SOURCE")

export PATH="$scripts_dir/bspwm:$PATH"
export PATH="$scripts_dir/sxhkd:$PATH"
export PATH="$scripts_dir/tmux:$PATH"
export PATH="$scripts_dir/utils:$PATH"
