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

function countingCurlAccess(){
cat "$accessLog" | cut -d' ' -f1,12 | grep "curl" | grep -v "127.0.0.1"| sort | uniq -c
}

countingCurlAccess
#pageCount
#getAllLogs
#ips
#echo "$allLogs"
#echo "$ipsAccessed"
