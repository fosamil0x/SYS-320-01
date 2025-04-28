#!/bin/bash

# This is the link we will scrape
link="10.0.17.6/IOC.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
toolOutput=$(echo "$fullPage" | xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet sel -t -m "//table/tr[position()>1]/td[1]" -v . -n)

echo "$toolOutput" > IOC.txt
