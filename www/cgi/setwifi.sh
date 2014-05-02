#!/bin/bash

ussid=''
upass=''
if [ -n "$QUERY_STRING" ]; then
	echo "here"
    exp=echo $QUERY_STRING | cut -d';' -f 1
    key=echo $exp | cut -d'=' -f 1
    value=echo $exp | cut -d'=' -f 2
    if [ "$key"x = "ssid"x ]; then
        ussid=$value
    elif [ "$key"x = "password"x ]; then
        upass=$value
    fi
elif [ -z "$1" -o -z "$2" ]; then
    echo "Need to specify ssid and password"
    exit 1
else
    ussid=$1
    upass=$2
fi

isFound="false"
iwpriv ra0 set SiteSurvey=0
OUTPUT=`iwpriv ra0 get_site_survey | grep '^[0-9]'`
while read line
do
ssid=`echo $line | awk '{print $2}'`
chanel=`echo $line | awk '{print $1}'`
bssid=`echo $line | awk '{print $3}'`
security=`echo $line | awk '{print $4}'`
signal=`echo $line | awk '{print $5}'`
wmode=`echo $line | awk '{print $6}'`
extch=`echo $line | awk '{print $7}'`
nt=`echo $line | awk '{print $8}'`
wps=`echo $line | awk '{print $9}'`

if [ "$ssid"x = "$ussid"x ]; then
	echo $ssid
	echo $chanel
	echo $security
	# Set interfaces file
	if [ -n `echo $security | grep WPA` ]; then
		sed 's/U_MODE/WPA2PSK/g' wpa_template | sed 's/U_PASS/'"$upass"'/g' | sed 's/U_CHANEL/'"$chanel"'/g' | sed 's/U_ENCRYP/AES/g' > /tmp/wireless
	fi
	# Restart network service
	/etc/init.d/network restart
    exit 0
fi
done <<EOF
$OUTPUT
EOF

echo "can not find wifi with ssid $ussid"
exit 2
