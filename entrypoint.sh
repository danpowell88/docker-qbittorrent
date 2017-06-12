#!/bin/bash
set -e

USER_ID=${USER_ID:-99}
GROUP_ID=${GROUP_ID:-100}

if ! grep -q $GROUP_ID /etc/group; then groupadd -g $GROUP_ID qbittorrent; fi

if ! id $USER_ID; then useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m qbittorrent; fi

mkdir -p /home/qbittorrent/.config

if [ ! -e /home/qbittorrent/.config/qBittorrent ]; then
  ln -s /config /home/qbittorrent/.config/qBittorrent
fi

qbittorrent-nox -v

export HOME=/home/qbittorrent

su -c "$@" -p qbittorrent
