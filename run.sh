#!/bin/sh

if [ ! -f /data/data.xml ]; then
    cp ./empty.xml /data/data.xml
    chown -R nginx:nginx /data
fi

echo "Start !"

exec nginx -g "daemon off;"
