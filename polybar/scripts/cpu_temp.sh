#!/bin/sh
# usage=$(mpstat | grep -A 5 "%idle" | tail -n 1 | awk -F " " '{print (100 -  $13)}')
# echo "$@"
temp=$(sensors | grep "Package id 0:" | tr -d '+' | awk '{print $4}')
echo $temp
