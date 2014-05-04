#!/bin/bash

if [ $TEMPLATE_DIR ]; then
    template_dir = $TEMPLATE_DIR
else
    template_dir=`pwd`"/../templates"
fi

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
    umode=""
    uencryp=""

	if [ "$security"x = "WPA1PSKWPA2PSK/TKIPAES"x ]; then
		umode="WPA2PSK"
        uencryp="AES"
	elif [ "$security"x = "WPA2PSK/AES"x ]; then
        umode="WPA2PSK"
        uencryp="AES"
    elif [ "$security"x = "WPA2PSK/TKIP"x ]; then
        umode="WPA2PSK"
        uencryp="TKIP"
    elif [ "$security"x = "WPAPSK/TKIPAES"x ]; then
        umode="WPAPSK"
        uencryp="TKIP"
    elif [ "$security"x = "WPAPSK/AES"x ]; then
        umode="WPAPSK"
        uencryp="AES"
    elif [ "$security"x = "WPAPSK/TKIP"x ]; then
        umode="WPAPSK"
        uencryp="TKIP"
    elif [ "$security"x = "WEP"x ]; then
        umode="WEP"
        uencryp="WEP"
    fi

    sed 's/U_MODE/'"$umode"'/g' "$template_dir""/wireless.template" | sed 's/U_SSID/'"$ussid"'/g' |sed 's/U_PASS/'"$upass"'/g' | sed 's/U_CHANEL/'"$chanel"'/g' | sed 's/U_ENCRYP/'"$uencryp"'/g' > /tmp/wireless
	# Restart network service
	/etc/init.d/network restart
    exit 0
fi
done <<EOF
$OUTPUT
EOF

echo "can not find wifi with ssid $ussid"
exit 2
