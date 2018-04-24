#!/bin/bash

source /opt/bin/.env

FILE_NAME=mysql\_`date +%d%m%Y_%H%M%S`.sql.tgz
HOST_DEST=$MYSQL_BACKUP_ROOT/$FILE_NAME

docker exec mysql sh -c \
  'exec mysqldump --all-databases -C -u root -p"'$MYSQL_ROOT_PASS'"' > $HOST_DEST

curl -X PUT \
  -u $NEXTCLOUD_USER:$NEXTCLOUD_PASS \
  $MYSQL_NEXTCLOUD_BACKUP_URL/$FILE_NAME \
  -F file=@$HOST_DEST
 
rm -rf $HOST_DEST

docker exec --user www-data nextcloud php occ files:scan --all
