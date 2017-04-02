FROM ubuntu:xenial

ARG QBITTORRENT_VERSION=3.3.11

RUN apt-get update && \
  # General required dependencies
  apt-get install -y libboost-dev libboost-system-dev build-essential && \
  # Qt4 libraries (optional and only if it exists in your distro's repo)
  apt-get install -y libqt4-dev && \
  # Qt5 libraries
  apt-get install -y qtbase5-dev qttools5-dev-tools && \
  # Python (Run time only dependency, for the search engine)
  apt-get install -y python && \
  # Geoip Database (For peer country resolution, strongly advised)
  apt-get install -y geoip-database && \
  # Libtorrent
  apt-get install -y libboost-system-dev libboost-chrono-dev libboost-random-dev libssl-dev libgeoip-dev && \
  # Tools
  apt-get install -y git pkg-config automake libtool
  
# Build Libtorrent
RUN git clone https://github.com/arvidn/libtorrent.git /usr/src/libtorrent && \
  cd /usr/src/libtorrent && \
  git checkout RC_1_1 && \
  ./autotool.sh && \
  ./configure --disable-debug --enable-encryption --prefix=/usr --with-libgeoip=system CXXFLAGS=-std=c++11 && \
  make clean && make && \
  make install && \
  rm -rf /usr/src/libtorrent
  
RUN git clone https://github.com/qbittorrent/qBittorrent.git /usr/src/qbittorrent && \
  cd /usr/src/qbittorrent && \
  git checkout release-${QBITTORRENT_VERSION} && \
  ./configure --prefix=/usr --disable-gui && \
  make && \
  make install && \
  rm -rf /usr/src/qbittorrent

COPY ./entrypoint.sh /

VOLUME ["/config", "/torrents", "/downloads"]

ENV USER_ID 107

ENV GROUP_ID 114

ENTRYPOINT ["/entrypoint.sh"]

CMD ["qbittorrent-nox"]
