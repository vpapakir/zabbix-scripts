#!/bin/bash

WHAT2CHECK=$1

if [ "$WHAT2CHECK" == "socket" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 4)
        #echo $RESULT
        if [ $RESULT == "true" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "moveinAdmin" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [ $RESULT == "true" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "movein" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $WHAT2CHECK'\"' | cut -d ":" -f 3)
        if [ "$RESULT" == "true" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "response" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "docmerge" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "docmerge" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "email" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $WHAT2CHECK'\"' | cut -d ":" -f 3 | cut -d " " -f 1)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "emailimport" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [ $RESULT == "true" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "filestorage" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [ $RESULT == "true" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "pdfcombine" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "url2pdf" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 3)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "zip" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/},{/\\n/g | grep $1 | cut -d ":" -f 4)
        #echo $RESULT
        if [[ $RESULT == "true" ]]; then
                echo "1";
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "0" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/0/\\n/g | sed s/1/\\n/g | grep name | grep "Connected to rabbitMQ" | cut -d ":" -f 4 | cut -d '"' -f 2)
        if [ "$RESULT" == "Connected" ]; then
                echo "1"
        else
                echo "0"
        fi
fi

if [ "$WHAT2CHECK" == "1" ]; then
        RESULT=$(php /var/www/htdocs/moveIn4-Service/public/index.php checkRabbit | sed s/0/\\n/g | sed s/1/\\n/g | grep name | grep "Get queue list from rabbitMQ" | cut -d ":" -f 4 | cut -d '"' -f 2)
        if [ "$RESULT" == "Success" ]; then
                echo "1"
        else
                echo "0"
        fi
fi