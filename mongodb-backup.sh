#!/bin/bash

source /opt/bin/.env

DB_NAME=$1
FILE_NAME=$DB_NAME\_`date +%d%m%Y_%H%M%S`

CONTAINER_DEST=/backup/$FILE_NAME
HOST_DEST=$MONGODB_BACKUP_ROOT/$FILE_NAME

docker exec mongodb \
  mongodump \
  -u $MONGODB_USER \
  -p $MONGODB_PASS \
  --authenticationDatabase admin \
  --db $DB_NAME \
  --out $CONTAINER_DEST \

cd $HOST_DEST
zip -r $HOST_DEST.zip *

rclone copy $HOST_DEST.zip drive:MongoDB/i-mutabakat

rm -rf $HOST_DEST*
