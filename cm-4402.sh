#!/bin/bash

USERNAME="XXX"
PASSWORD="XXX"
STANDALONEDBHOST="XXXXXX"
CLUSTERDBHOST="XXXXXX"

echo "" > ./cm-4402a.log
echo "" > ./cm-4402b.log

while IFS= read -r id; do
        ins=`echo $id | awk '{print $9}'`

        EXISTSINCENTRALDB=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_central -e "select count(id_ins) from instance_ins where id_ins=$ins;" || echo "0")
        DOMAININS=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_central -e "select domain_ins from instance_ins where id_ins=$ins;" || echo "no-domain")
        EXISTSINSTANDALONEDB=$(mysql -u $USERNAME -p$PASSWORD -h $STANDALONEDBHOST -N -B --default-character-set=utf8 qsu_mweb_institution_$ins -e "select 1;" || echo "0")
        EXISTSINCLUSTERDB=$(mysql -u $USERNAME -p$PASSWORD -h $CLUSTERDBHOST -N -B --default-character-set=utf8 qsu_mweb_institution_$ins -e "select 1;" || echo "0")

        echo $id" CENTRALDB: "$EXISTSINCENTRALDB" DOMAINCONFIG: "$DOMAININS" STDB: "$EXISTSINSTANDALONEDB" CLUSTDB: "$EXISTSINCLUSTERDB >> ./cm-4402a.log

        if [[ -z "${DOMAININS// }" ]];then
                DOMAININS="no-domain"
                echo $id seems to have no domain
        else
                if [ -f /var/local/instance_configs/domainconfig_$DOMAININS.ini ]; then
                        EXISTSINCONFIGS=1
                else
                        EXISTSINCONFIGS=0
                fi

                if [ $EXISTSINCENTRALDB == "0"  ]; then
                #if [ $DOMAININS == "no-domain" ] && [ $EXISTSINCENTRALDB == "0"  ] && [ $EXISTSINSTANDALONEDB == "0" ] && [ $EXISTSINCLUSTERDB == "0" ]; then
                        echo "INSTANCE $ins / $DOMAININS: | $EXISTSINCENTRALDB | $EXISTSINSTANDALONEDB | $EXISTSINCLUSTERDB | $EXISTSINCONFIGS" >> ./cm-4402b.log
                fi
        fi

done < <(ssh epapakirykou@172.31.0.99 "ls -l /var/local/uploads/ | egrep '^d' | grep -v 'captcha' | grep -v 'lost+found'")