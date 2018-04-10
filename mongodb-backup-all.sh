#!/bin/bash

source /opt/bin/.env

for DB_NAME in ${MONGODB_DBS//,/ }
do
  FILE_NAME=$DB_NAME\_`date +%d%m%Y_%H%M%S`

  CONTAINER_DEST=/backups/$FILE_NAME
  HOST_DEST=$MONGODB_BACKUP_ROOT/$FILE_NAME

  docker exec mongodb \
    mongodump \
    --db $DB_NAME \
    --out $CONTAINER_DEST \

  cd $HOST_DEST
  zip -r $HOST_DEST.zip *
  curl -X PUT \
    -u $NEXTCLOUD_USER:$NEXTCLOUD_PASS \
    $MONGODB_NEXTCLOUD_FTP_BACKUP_URL/$FILE_NAME.zip \
    -F file=@$HOST_DEST.zip
 
  rm -rf $HOST_DEST*
done

docker exec --user www-data nextcloud php occ files:scan --all