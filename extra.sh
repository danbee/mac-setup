#!/bin/sh
MAC_SETUP_DIR="$HOME/mac-setup"

BOLD="\033[1m"
WHITE="\033[0;37m"
YELLOW="\033[1;33m"
GREEN="\033[1;32m"
NC="\033[0m"

step() {
  echo "${YELLOW}❯❯❯ ${WHITE}${BOLD}$1${NC} ${YELLOW}❮❮❮${NC}"
}

# Install brew bundles
step "Installing Homebrew bundle extra"
brew bundle --file="$MAC_SETUP_DIR/Brewfile.extra"
