#!/bin/sh

cd "$HOME"

if [ $SHELL != $(which zsh) ]; then
  chsh -s $(which zsh)
fi

if [ ! -d "$HOME/dotfiles" ]; then
  git clone git@github.com:thoughtbot/dotfiles.git
else
  pushd "$HOME/dotfiles"
  git pull
  popd
fi

if [ ! -d "$HOME/dotfiles-local" ]; then
  git clone git@github.com:danbee/dotfiles-local.git
  pushd "$HOME/dotfiles"
  git submodule init
  git submodule update
  popd
else
  pushd "$HOME/dotfiles-local"
  git pull
  popd
fi

env RCRC="$HOME/dotfiles-local/rcrc" rcup
