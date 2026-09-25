#!/bin/bash

version="$1"

if [ -z "$version" ]; then
  echo "Usage: $0 <version>"
  exit 1
fi

sed -i "s/\"version\": \".*\"/\"version\": \"$version\"/" info.json
zip -r bob-newopenai-explainer.bobplugin info.json main.js icon.png

set -x

min_bob_version=$(sed -nr "s/^.*minBobVersion\": \"(.*?)\",$/\1/p" info.json)

sha256=$(shasum -a 256 bob-newopenai-explainer.bobplugin | cut -d" " -f1) 

sed -i '3a\
        {\
          "version": "'$version'",\
          "desc": "'$version'",\
          "sha256": "'$sha256'",\
          "url": "https://github.com/jiayouzl/bob-newopenai-explainer/releases/download/'$version'/bob-newopenai-explainer.bobplugin",\
          "minBobVersion": "'$min_bob_version'"\
        },' appcast.json

