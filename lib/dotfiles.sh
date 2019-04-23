#!/bin/sh

cd "$HOME"

if [ $SHELL != $(which zsh) ]; then
  chsh -s $(which zsh)
fi

if [ ! -d "$HOME/dotfiles" ]; then
  git clone git@github.com:thoughtbot/dotfiles.git
else
  cd "$HOME/dotfiles"
  git pull
  cd -
fi

if [ ! -d "$HOME/dotfiles-local" ]; then
  git clone git@github.com:danbee/dotfiles-local.git
else
  cd "$HOME/dotfiles-local"
  git pull
  cd -
fi

env RCRC="$HOME/dotfiles/rcrc" rcup
