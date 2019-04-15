#!/bin/sh

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# We want to be in the user home directory.
cd ~

# Get Brewfiles.
echo 'Downloading...'
curl -s https://raw.githubusercontent.com/danbee/mac-setup/master/Brewfile > ~/Brewfile
curl -s https://raw.githubusercontent.com/danbee/mac-setup/master/mas.sh > ~/mas.sh
chmod +x ~/mas.sh

# Install brew bundles
echo 'Installing Homebrew bundle...'
brew bundle

# Install Mac App Store apps
echo 'Installing App Store apps'
~/mas.sh

echo 'Done!'

