#!/bin/sh

docker build -t golang-demo:${1:-latest} .

