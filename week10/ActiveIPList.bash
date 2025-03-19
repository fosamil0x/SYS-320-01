#!/bin/bash

# list ip's in a given network prefix
# /24 only

# usage: bash IPList.bash 10.0.17
[ "$#" -ne 1 ] && echo "Usage: $0 <Prefix>" && exit 1

# prefix is the first input taken
prefix="$1"

# Verify Input Length
[ ${#prefix} -lt 5 ] && \
printf "Prefix is too short\nPrefix example: 10.0.17\n" && \
exit 1

for i in {0..254}
do
	ping -c 1  "${prefix}.$i" | grep "64 bytes" | \
	grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

done
