#!/bin/sh

docker run -it --rm -p 127.0.0.1:6666:6666 golang-demo:${1:-latest}

