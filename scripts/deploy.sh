#!/bin/bash

set -e

readonly CWD=$(dirname $0)

export GOOS=linux
export GOARCH=amd64

for i in 1; do
# for i in {1..3}; do
  ssh kayac-isucon-2022 "cd ~/webapp; docker-compose down"
  rsync -av webapp/golang/*.go kayac-isucon-2022:~/webapp/golang/
  ssh kayac-isucon-2022 "cd ~/webapp; docker-compose up --build -d"
done
