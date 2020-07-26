#!/bin/bash

echo -e "stats\nquit" | nc 127.0.0.1 $1 | grep $2 | cut -d " " -f3