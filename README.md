# docker-qbittorrent
A qbittorrent docker image in Ubuntu. Supports custom UID/GID

## Usage
You will want to provide a volume for persistent configs. This image looks for configs at `/configs`. You need to start the image one and accept the license before running as a daemon. The license acceptance is stored in your config after first run.

```bash
docker run -p 8080:8080 -it -v $PWD:/configs justmiles/qbittorrent
```

## Environment Variables

- USER_ID - id of user running qBittorrent. Defaults to 107
- GROUP_ID - group id of user running qBittorrent. Defaults to 114
