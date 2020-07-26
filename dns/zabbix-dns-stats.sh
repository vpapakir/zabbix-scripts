#!/bin/bash
 
STATSFILE="/var/named/data/named_stats.txt"
METRIC=$1
RECORD=$2

if [ $METRIC == "IN" ]; then
	out=$(awk '
	    BEGIN       {A=0;AAAA=0;ANY=0;CNAME=0;MX=0;NS=0;PTR=0;SOA=0;SRV=0;SPF=0;TXT=0;}
    		/Incoming Queries/, /Outgoing Queries/ {
	        if($2 == "A")     {A = $1}
        	if($2 == "AAAA")  {AAAA = $1}
	        if($2 == "ANY")   {ANY = $1}
	        if($2 == "CNAME") {CNAME = $1}
	        if($2 == "MX")    {MX = $1}
	        if($2 == "NS")    {NS = $1}
	        if($2 == "PTR")   {PTR = $1}
	        if($2 == "SOA")   {SOA = $1}
	        if($2 == "SRV")   {SRV = $1}
		if($2 == "SPF")   {SPF = $1}
		if($2 == "TXT")   {TXT = $1}
    	}
    	END         {print A ":" AAAA ":" ANY ":" CNAME ":" MX ":" NS ":" PTR ":" SOA ":" SRV ":" SPF ":" TXT}' $STATSFILE)
	if [ $2 == "A" ];then
		echo $out | cut -d ":" -f 1
	fi
        if [ $2 == "AAAA" ];then
                echo $out | cut -d ":" -f 2
        fi
        if [ $2 == "ANY" ];then
                echo $out | cut -d ":" -f 3
        fi
        if [ $2 == "CNAME" ];then
                echo $out | cut -d ":" -f 4
        fi
        if [ $2 == "MX" ];then
                echo $out | cut -d ":" -f 5
        fi
        if [ $2 == "NS" ];then
                echo $out | cut -d ":" -f 6
        fi
        if [ $2 == "PTR" ];then
                echo $out | cut -d ":" -f 7
        fi
        if [ $2 == "SOA" ];then
                echo $out | cut -d ":" -f 8
        fi
        if [ $2 == "SRV" ];then
                echo $out | cut -d ":" -f 9
        fi
        if [ $2 == "SPF" ];then
                echo $out | cut -d ":" -f 10
        fi
        if [ $2 == "TXT" ];then
                echo $out | cut -d ":" -f 11
        fi
fi

if [ $METRIC == "OUT" ]; then
#        gawk '/++ Outgoing Queries ++/, /++ Name Server Statistics ++/' $STATSFILE | grep $RECORD | awk '{print $1}'
        out=$(awk '
            BEGIN       {A=0;AAAA=0;ANY=0;CNAME=0;MX=0;NS=0;PTR=0;SOA=0;SRV=0;SPF=0;TXT=0;}
                /Outgoing Queries/,/Name Server Statistics/ {
                if($2 == "A")     {A = $1}
                if($2 == "AAAA")  {AAAA = $1}
                if($2 == "ANY")   {ANY = $1}
                if($2 == "CNAME") {CNAME = $1}
                if($2 == "MX")    {MX = $1}
                if($2 == "NS")    {NS = $1}
                if($2 == "PTR")   {PTR = $1}
                if($2 == "SOA")   {SOA = $1}
                if($2 == "SRV")   {SRV = $1}
                if($2 == "SPF")   {SPF = $1}
                if($2 == "TXT")   {TXT = $1}
        }
        END         {print A ":" AAAA ":" ANY ":" CNAME ":" MX ":" NS ":" PTR ":" SOA ":" SRV ":" SPF ":" TXT}' $STATSFILE)
        if [ $2 == "A" ];then
                echo $out | cut -d ":" -f 1
        fi
        if [ $2 == "AAAA" ];then
                echo $out | cut -d ":" -f 2
        fi
        if [ $2 == "ANY" ];then
                echo $out | cut -d ":" -f 3
        fi
        if [ $2 == "CNAME" ];then
                echo $out | cut -d ":" -f 4
        fi
        if [ $2 == "MX" ];then
                echo $out | cut -d ":" -f 5
        fi
        if [ $2 == "NS" ];then
                echo $out | cut -d ":" -f 6
        fi
        if [ $2 == "PTR" ];then
                echo $out | cut -d ":" -f 7
        fi
        if [ $2 == "SOA" ];then
                echo $out | cut -d ":" -f 8
        fi
        if [ $2 == "SRV" ];then
                echo $out | cut -d ":" -f 9
        fi
        if [ $2 == "SPF" ];then
                echo $out | cut -d ":" -f 10
        fi
        if [ $2 == "TXT" ];then
                echo $out | cut -d ":" -f 11
        fi

fi