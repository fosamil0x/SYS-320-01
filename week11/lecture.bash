#!/bin/bash

allLogs=""
accessLog="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$accessLog" | cut -d' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo " $allLogs" | cut -d' ' -f1)
}

function pageCount(){
cat "$accessLog" | cut -d' ' -f7 | sort | uniq -c | sort -nr
}

pageCount
#getAllLogs
#ips
#echo "$allLogs"
#echo "$ipsAccessed"
