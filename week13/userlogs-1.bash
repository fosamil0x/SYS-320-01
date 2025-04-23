#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
 logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
 dateAndUser=$(echo "$logline" | cut -d' ' -f1,3,12 | tr -d '\.')
 echo "$dateAndUser" 
}


getLogins
function getFailedLogins(){
# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
 fail=$(cat "$authfile"| grep "authentication failure" | grep -v COMMAND | cut -d' ' -f1,3,17)
 echo "$fail"
}

getFailedLogins
# Sending logins as email - Do not forget to change email address
# to your own email address
echo "To: luc.evans@mymail.champlain.edu" > emailform.txt
echo "Subject: Logins" >> emailform.txt
getLogins >> emailform.txt
cat emailform.txt | ssmtp luc.evans@mymail.champlain.edu

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email 

echo "To: luc.evans@mymail.champlain.edu" > loginEmail.txt
echo "Subject: Failed Logins" >> loginEmail.txt
getFailedLogins >> loginEmail.txt
cat loginEmail.txt | ssmtp luc.evans@mymail.champlain.edu
