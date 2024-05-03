#!/usr/bin/bash

cd ~/.dotfiles
stow --no-folding -R .
cd ~/.private_dotfiles
stow --no-folding -R .

