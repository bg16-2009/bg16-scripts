#!/bin/bash

# Opens konsole with tmux attached with UTF-8 support
# This can be mapped to CTRL-ALT-T

if tmux ls &> /dev/null; then
    konsole -e "tmux -u attach"
else
    konsole -e "tmux -u"
fi
