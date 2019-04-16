#!/bin/sh

DOTFILES="$HOME/dotfiles-local"

if [ ! -f "$DOTFILES/gitconfig.author" ]; then
  cp "$DOTFILES//gitconfig.author.example" "$DOTFILES/gitconfig.author"
  vim "$DOTFILES/gitconfig.author"
fi
