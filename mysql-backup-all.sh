#!/bin/bash

source /opt/bin/.env

#FILE_NAME=mysql\_`date +%d%m%Y_%H%M%S`.sql.tgz

FILE_NAME=contabo.sql.tgz
HOST_DEST=$MYSQL_BACKUP_ROOT/$FILE_NAME

docker exec mysql sh -c \
  'exec mysqldump --all-databases -C -u root -p"'$MYSQL_ROOT_PASS'"' > $HOST_DEST

rclone copy $HOST_DEST drive:MySQL

rm -rf $HOST_DEST
