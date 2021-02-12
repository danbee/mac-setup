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

# Ask for the administrator password upfront
sudo -v

# Generate an SSH key if one does not already exist
if [ ! -f "$HOME/.ssh/id_ed25519.pub" ]; then
  step "Generating SSH key"
  ssh-keygen -t ed25519 -f "$HOME/.ssh/id_ed25519"
  echo "Copy and paste the public portion of the key (below) to GitHub"
  echo "============ Public key ============="
  cat ~/.ssh/id_ed25519.pub
  echo "====================================="
  . read -r -p "Press any key to continue... " -n 1
fi

# Add the SSH key to the agent now to avoid multiple prompts
if ! ssh-add -L -q > /dev/null ; then
  ssh-add
fi

# Install Homebrew
step "Installing Homebrew"
if ! type brew > /dev/null; then
  /bin/bash -c \
    "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval $(/opt/homebrew/bin/brew shellenv)' >> /Users/danbarber/.zprofile
  eval $(/opt/homebrew/bin/brew shellenv)
fi

# Clone setup repo
if [ ! -d "$MAC_SETUP_DIR" ]; then
  git clone git@github.com:danbee/mac-setup.git "$HOME/mac-setup"
else
  pushd "$MAC_SETUP_DIR"
  git pull
  popd
fi

# Install brew bundles
step "Installing Homebrew bundle"
brew bundle --file="$MAC_SETUP_DIR/Brewfile"

# Install dotfiles
step "Installing dotfiles"
"$MAC_SETUP_DIR/lib/dotfiles.sh"

# Change the shell
step "Changing shell to zsh"
"$MAC_SETUP_DIR/lib/shell.sh"

# Setup git author
step "Set git author"
"$MAC_SETUP_DIR/lib/git_author.sh"

# Setup `chunkwm`
step "Setting up Yabai"
"$MAC_SETUP_DIR/lib/yabai.sh"

# Tweak the hell out of macOS settings
step "Tweaking macOS config settings (takes a while)"
"$MAC_SETUP_DIR/lib/macos.sh"

# Install language tools
step "Installing language tools"
"$MAC_SETUP_DIR/lib/tools.sh"

echo "${GREEN}✔ ${WHITE}${BOLD}Done!${NC} 🎉"
