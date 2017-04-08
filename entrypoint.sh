#!/bin/bash
set -e

USER_ID=${USER_ID:-107}
GROUP_ID=${GROUP_ID:-114}

if ! grep -q $GROUP_ID /etc/group; then groupadd -g $GROUP_ID qbittorrent; fi

if ! grep -q $USER_ID /etc/passwd; then useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m qbittorrent; fi

chown -R qbittorrent.qbittorrent /config /torrents /downloads

mkdir -p /home/qbittorrent/.config

if [ ! -e /home/qbittorrent/.config/qBittorrent ]; then
  ln -s /config /home/qbittorrent/.config/qBittorrent
fi

qbittorrent-nox -v

export HOME=/home/qbittorrent

su -c "$@" -p qbittorrent
