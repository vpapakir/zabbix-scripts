#!/bin/bash

INSTANCE_DOMAIN=$1
DBUSER="XXX"
DBPASS="XXX"
MONGO_DB_USER="XXX"
MONGO_DB_PASS="XXX"
CENTRALDB="XXX"
PLATFORMDBHOST="XXX"
PLATFORMPHPHOST="XXX"
CENTRAL_DB_USER="XXX"
CENTRAL_DB_PASS="XXX"
MONGOHOST="XXX"
PLATFORMUNAME="XXX"
PLATFORMPASS="XXX"

INSTANCE_ID=$(mysql -N -B -h $CENTRALDB -u $CENTRAL_DB_USER -p$CENTRAL_DB_PASS --default-character-set=utf8 qsu_mweb_central -e "select id_ins from instance_ins where domain_ins='$INSTANCE_DOMAIN'")
DBHOST=$(cat /var/local/instance_configs/domainconfig_$INSTANCE_DOMAIN.ini | grep overwrite)
if [ "$DBHOST" == "" ]; then
        DBHOST="m4-live-mysql56-db"
else
        DBHOST=$(cat /var/local/instance_configs/domainconfig_$INSTANCE_DOMAIN.ini | grep overwrite | cut -d " " -f 3 | sed 's/"//g')
fi

sudo rm -v /var/local/instance_configs/domainconfig_$INSTANCE_DOMAIN.ini
sudo rm -v /var/local/instance_configs/general_instance_$INSTANCE_ID.xml
sudo rm -v /var/local/instance_configs/instance_$INSTANCE_ID.ini
sudo rm -rv /var/local/instance_configs/$INSTANCE_DOMAIN/
sudo rm -rv /var/local/uploads/$INSTANCE_ID/

mysql -v -h $DBHOST -u $CENTRAL_DB_USER -p$CENTRAL_DB_PASS --default-character-set=utf8 qsu_mweb_central -e "delete from instance_ins where id_ins=$INSTANCE_ID"
mysql -v -h $DBHOST -u $CENTRAL_DB_USER -p$CENTRAL_DB_PASS --default-character-set=utf8 -e "drop database qsu_mweb_institution_$INSTANCE_ID"

mongo --host $MONGOHOST -u $MONGO_DB_USER -p$MONGO_DB_PASS qsu_mweb_institution_$INSTANCE_ID --authenticationDatabase admin --eval "db.dropDatabase()"

mysql -h $PLATFORMDBHOST -u $PLATFORMUNAME -p$PLATFORMPASS file_storage -e "drop table file_details_$INSTANCE_ID"

# TODO: Make a separate script for deleting platform files