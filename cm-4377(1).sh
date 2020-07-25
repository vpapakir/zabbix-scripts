#!/bin/bash

USERNAME="XXXX"
PASSWORD="XXXX"
STANDALONEDBHOST="XXXX"
CLUSTERDBHOST="XXXX"
SSHUSER="XXXX"
STORAGEHOST="XXXX"

echo "" > ./cm-4377.log

while IFS= read -r id; do
        ins=`echo $id | awk '{print $9}'`

        EXISTSINCENTRALDB=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_central -e "select count(id_ins) from instance_ins where id_ins=$ins;" || echo "0")
        DOMAININS=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_central -e "select domain_ins from instance_ins where id_ins=$ins;" || echo "no-domain")
        EXISTSINSTANDALONEDB=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_institution_$ins -e "select 1;" || echo "0")
        EXISTSINCLUSTERDB=$(mysql -u $USERNAME -p$PASSWORD -h $CLUSTERDBHOST -N -B --default-character-set=utf8 qsu_mweb_institution_$ins -e "select 1;" || echo "0")

        if [[ -z "${DOMAININS// }" ]];then
                DOMAININS="no-domain"
        fi

        if [ -f /var/local/instance_configs/domainconfig_$DOMAININS.ini ]; then
                EXISTSINCONFIGS=1
        else
                EXISTSINCONFIGS=0
        fi

        if [ $DOMAININS == "no-domain" ] && [ $EXISTSINCENTRALDB == "0"  ] && [ $EXISTSINSTANDALONEDB == "0" ] && [ $EXISTSINCLUSTERDB == "0" ]; then
                echo "INSTANCE $ins / $DOMAININS: | $EXISTSINCENTRALDB | $EXISTSINSTANDALONEDB | $EXISTSINCLUSTERDB | $EXISTSINCONFIGS" >> ./cm-4377.log
        fi

done < <(ssh $SSHUSER@$STORAGEHOST "ls -l /var/local/uploads/ | egrep '^d' | grep -v 'captcha' | grep -v 'lost+found'")