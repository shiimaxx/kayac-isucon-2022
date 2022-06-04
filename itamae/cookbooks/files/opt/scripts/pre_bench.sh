#!/bin/bash

readonly CWD=$(dirname $0)

rm -f /tmp/profile/*
rm -f /home/isucon/webapp/mysql/logs/mysql-slow.log
rm -f /home/isucon/webapp/nginx/logs/access.log

${CWD}/restart.sh
