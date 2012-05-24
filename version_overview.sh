#!/bin/bash
#Versionsübersicht
#Dennis Wisnia
#http://dennis-wisnia.de

applist=apps.txt
tmpfile=/tmp/applist-$$.tmp
result=result.txt

rm $result
echo "OS Version:" >> $result
cat /etc/issue >> $result
echo " " >> $result 
echo "Apps Versionen:" >> $result
echo " " >> $result
for i in $(cat $applist); do
    dpkg -l | grep $i >> $tmpfile
    cat $tmpfile | awk '{printf "|%s|%s|\n", $2, $3}' >> $result
    rm $tmpfile
done
echo " " >> $result
echo "Backports:" >>  $result
echo " " >> $result
for i in $(cat $applist);  do
    dpkg -l | grep "bpo" >> $tmpfile
    cat $tmpfile | awk '{printf "|%s|%s|\n", $2, $3}' | grep --color [0-9]\.[0-9]\.[0-9]-[0-9]~bpo >> $result
    rm $tmpfile
done

