#!/bin/sh

export DOCKER_BUILDKIT=0
docker build -t golang-demo:${1:-latest} .

