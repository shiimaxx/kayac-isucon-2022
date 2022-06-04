#!/bin/bash

export PATH=${PATH}:/usr/local/bin

cat /home/isucon/webapp/nginx/logs/access.log | kataribe -f /opt/kataribe.toml > /opt/logs/access-totalize.log
pt-query-digest /home/isucon/webapp/mysql/logs/mysql-slow.log > /opt/logs/slowquery-totalize.log
# mysqltuner > /opt/logs/mysqltuner 2>/dev/null
