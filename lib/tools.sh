#!/bin/sh

export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"

pushd "$HOME"

for tool in `awk -F " " '{print $1}' .tool-versions`; do
  asdf plugin-add "$tool"

  if [ "$tool" == "nodejs" ]; then
    bash "$HOME/.asdf/plugins/nodejs/bin/import-release-team-keyring"
  fi
done

asdf install

popd
