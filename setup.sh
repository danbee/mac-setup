#!/bin/sh

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# We want to be in the user home directory.
cd ~

# Tap boneyard for bundle command
brew tap homebrew/boneyard

# Get Brewfiles.
echo 'Downloading Brewfiles...'
curl -s https://raw.githubusercontent.com/danbee/mac-setup/master/Brewfile > ~/Brewfile
curl -s https://raw.githubusercontent.com/danbee/mac-setup/master/Caskfile > ~/Caskfile

# Install brew bundles
echo 'Installing...'
brew bundle && brew bundle Caskfile

echo 'Done!'

