#!/bin/sh

DT_TIME=$(date +'%Y-%m-%d:%H:%M:%S:%6N')

echo "$DT_TIME From 20-script.sh $1 $2" >> /tmp/NMTESTFILE.txt

