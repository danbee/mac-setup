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

# Generate an SSH key if one does not already exist
if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
  step "Generating SSH key"
  ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
  echo "Copy and paste the public portion of the key (below) to GitHub"
  echo "and press a key when done."
  echo "=========== Public key =============="
  cat ~/.ssh/id_ed25519.pub
  echo "====================================="
  read -n 1 -s
fi

# Clone setup repo
if [ ! -d "$MAC_SETUP_DIR" ]; then
  git clone git@github.com:danbee/mac-setup.git "$HOME/mac-setup"
else
  cd "$MAC_SETUP_DIR"
  git pull
  cd -
fi

# Install Homebrew
step "Installing Homebrew"
"$MAC_SETUP_DIR/lib/homebrew.sh"

# Install brew bundles
step "Installing Homebrew bundle"
brew bundle --file="$MAC_SETUP_DIR/Brewfile"

# Install Mac App Store apps
step "Installing App Store apps"
"$MAC_SETUP_DIR/lib/mas.sh"

# Install dotfiles
step "Installing dotfiles"
"$MAC_SETUP_DIR/lib/dotfiles.sh"

# Setup git author
step "Set git author"
"$MAC_SETUP_DIR/lib/git_author.sh"

echo "${GREEN}✔ ${WHITE}${BOLD}Done!${NC} 🎉"
