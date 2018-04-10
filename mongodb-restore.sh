#!/bin/bash

source /opt/bin/.env

read -p "Veritabanı: " DB_NAME

if [[ -z $DB_NAME ]]; then
  exit
fi

echo "Veritabanındaki tüm kayıtlar silinecektir."
read -p "Emin misiniz (e/H)?" RESPONSE

if [[ $RESPONSE =~ ^(e|E|) ]] && [[ ! -z $RESPONSE ]]; then
  docker exec -it mongodb mongorestore \
    --db $DB_NAME \
    --drop \
    --dir /backups/$DB_NAME \
fi
