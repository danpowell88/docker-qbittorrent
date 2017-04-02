#!/bin/bash

function buildAndPush {
  docker build . --build-arg QBITTORRENT_VERSION=$1 -t justmiles/qbittorrent:$1 && docker push justmiles/qbittorrent:$1
  docker tag justmiles/qbittorrent:$1 justmiles/qbittorrent:latest
  docker push justmiles/qbittorrent:latest
}

git clone https://github.com/qbittorrent/qBittorrent.git

latest=$(git --git-dir=qBittorrent/.git tag | xargs -I@ git --git-dir=qBittorrent/.git log --format=format:"%ai @%n" -1 @ | sort | awk '{print $4}' | sed 's/release-//' | tail -1)

docker pull justmiles/qbittorrent:$latest > /dev/null 2>&1
exists=$?

if [ $exists -gt 0 ]; then
  buildAndPush $latest
else
  exit 0
fi
