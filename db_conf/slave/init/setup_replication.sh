#!/bin/bash
set -e

echo "Waiting for master to be ready..."
until mysqladmin ping -h database-master -urepl -preplpass --silent; do
  echo "Waiting..."
  sleep 2
done

echo "Master is reachable"

REPL_STATUS=$(mysql -u root -proot -sse "SELECT COUNT(*) FROM information_schema.processlist WHERE USER = 'repl';")

if [ "$REPL_STATUS" -eq 0 ]; then
  echo "Setting up replication..."
  mysql -u root -proot <<EOF
CHANGE MASTER TO
  MASTER_HOST='database-master',
  MASTER_USER='repl',
  MASTER_PASSWORD='replpass',
  MASTER_AUTO_POSITION=1;
START SLAVE;
EOF
else
  echo "Replication already configured."
fi
