#!/bin/bash

df -h | grep "eos-filestorage" | awk '{print $5}' | grep "1%" | wc -l