#!/bin/bash

STATSFILE="/var/named/data/named_stats.txt"
METRIC=$1
RECORD=$2

echo "" > $STATSFILE

rndc -c /etc/rndc-zabbix.conf stats

if [ $METRIC == "IN" ]; then
        gawk '/++ Incoming Queries ++/, /++ Outgoing Queries ++/' $STATSFILE | grep $RECORD | awk '{print $1}'
fi

if [ $METRIC == "OUT" ]; then
        gawk '/++ Outgoing Queries ++/, /++ Name Server Statistics ++/' $STATSFILE | grep $RECORD | awk '{print $1}'
fi

if [ $METRIC == "1" ]; then
        gawk '/++ Incoming Requests ++/, /++ Incoming Queries ++/' $STATSFILE | grep QUERY | awk '{print $1}'
fi