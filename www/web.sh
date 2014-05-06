#!/bin/sh
base=/etc/xhi/www
read request


while true
do
read header
[ "$header" == $'\r' ] && break;
done


url="${request#GET }"
url="${url% HTTP/*}"
query="${url#*\?}"
url="${url%%\?*}"


if [ $url == "/" ]; then
url="/index.html"
fi


filename="$base$url"
if [ -x "$filename" ]; then
echo -e "HTTP/1.1 200 OK\r"
echo -e "Content-Type: application/json\r"
echo -e "\r"
export QUERY_STRING=$query
"$filename"
echo -e "\r"
elif [ -f "$filename" ]; then
echo -e "HTTP/1.1 200 OK\r"
echo -e "Content-Type: `/usr/bin/file -bi \"$filename\"`\r"
echo -e "\r"
cat "$filename"
echo -e "\r"
else
echo -e "HTTP/1.1 404 Not Found\r"
echo -e "Content-Type: text/html\r"
echo -e "\r"
echo -e "404 Not Found\r"
echo -e "Not Found The requested resource was not found\r"
echo -e "\r"
fi

