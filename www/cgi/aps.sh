#!/bin/bash
i=0
echo "{"
iwpriv ra0 set SiteSurvey=0
iwpriv ra0 get_site_survey | grep '^[0-9]' | while read line
do
chanel=`echo $line | awk '{print $1}'`
ssid=`echo $line | awk '{print $2}'`
bssid=`echo $line | awk '{print $3}'`
security=`echo $line | awk '{print $4}'`
signal=`echo $line | awk '{print $5}'`
wmode=`echo $line | awk '{print $6}'`
extch=`echo $line | awk '{print $7}'`
nt=`echo $line | awk '{print $8}'`
wps=`echo $line | awk '{print $9}'`

if [ $i -ne 0 ]; then
echo ","
fi
i=$[i+1]
echo "\"$ssid\":{"
echo "\"chanel\":"$chanel","
#echo "\"ssid\":\""$ssid"\","
echo "\"bssid\":\""$bssid"\","
echo "\"security\":\""$security"\","
echo "\"signal\":"$signal","
echo "\"wmode\":\""$wmode"\","
echo "\"extch\":\""$extch"\","
echo "\"nt\":\""$nt"\","
echo "\"wps\":\""$wps"\""
echo -n "}"
done
echo "}"

