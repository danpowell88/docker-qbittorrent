#!/bin/bash
set -e

USER_ID=${USER_ID:-107}
GROUP_ID=${GROUP_ID:-114}

groupadd -g $GROUP_ID qbittorrent

useradd --shell /bin/bash -u $USER_ID -g $GROUP_ID -o -c "" -m qbittorrent

chown -R qbittorrent.qbittorrent /config /torrents /downloads

mkdir -p /home/qbittorrent/.config/qBittorrent

ln -s /config /home/qbittorrent/.config/qBittorrent

su qbittorrent

cd

qbittorrent-nox -v

exec "$@"