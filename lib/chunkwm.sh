#!/bin/sh

# Ask the user to generate a code signing key for `chunkwm`
echo "Please generate a code signing certificate called 'chunkwm-cert' in Keychain Access"
read -r -p "Press any key to continue... " -n 1

# We need to code sign chunkwm and skhd in order for them to be added to the
# accessibility allowed list.
codesign -fs "chunkwm-cert" $(which chunkwm)
codesign -fs "chunkwm-cert" $(which skhd)

# Start chunkwm
brew services start chunkwm
brew services start skhd
