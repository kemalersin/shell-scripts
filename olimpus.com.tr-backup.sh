#!/bin/bash

source /opt/bin/.env

FILE_NAME=olimpus.com.tr.zip
HOST_DEST=$WORDPRESS_BACKUP_ROOT/$FILE_NAME

zip -r $HOST_DEST /opt/wordpress/olimpus.com.tr

rclone copy $HOST_DEST drive:Wordpress

rm -rf $HOST_DEST
