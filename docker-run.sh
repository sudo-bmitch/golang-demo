#!/bin/sh

docker run -it --rm \
  --read-only --mount type=tmpfs,destination=/app/run,tmpfs-mode=1777 \
  --cap-drop NET_RAW --cap-drop CHOWN \
  -p 127.0.0.1:6666:6666 golang-demo:${1:-latest}

