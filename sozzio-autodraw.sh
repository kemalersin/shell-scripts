#!/bin/bash

source /opt/bin/.env

curl --data 'autoDrawSecret='$SOZZIO_AUTODRAW_SECRET https://fabrik.sozzio.com/autodraw --trace-ascii /dev/stdout
