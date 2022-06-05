#!/bin/bash

GIT_DIR=$(dirname ${0})/../.git
LOGS_DIR=$(dirname ${0})/../logs

echo -n "[commit.sh] msg: "
read msg

echo -n "[commit.sh] score: "
read score

commit_message=""

if [ -n "${score}" ]; then
  commit_message="[${score}] "
fi
commit_message="${commit_message}${msg}"

echo "[commit.sh] fetch logs from isucon server..."
rsync -av kayac-isucon-2022:/opt/logs/ ${LOGS_DIR}
echo "[commit.sh] done"; echo ""

git --git-dir=${GIT_DIR} add .
git --git-dir=${GIT_DIR} commit -m "${commit_message}"
