#! /bin/bash

# Incron IN-ACCESS assignment goes here

# write the time + date for when the file is accessed to fileaccesslog.txt
echo "File was accessed on $(date +"%m/%d/%Y %H-%M-%S")" >> fileaccesslog1.txt

# email the contents of fileaccesslog.txt
echo "To: luc.evans@mymail.champlain.edu" > newemail1.txt
echo "Subject: File Access" >> newemail1.txt
cat fileaccesslog1.txt >> newemail1.txt
cat newemail1.txt | ssmtp luc.evans@mymail.champlain.edu
