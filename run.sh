#!/bin/sh

if [ ! -f /etc/nginx/nginx.conf ]; then
    echo "Configure Service"

    PUID=${PUID}
    PGID=${PGID}

    export USER
    export GROUP

    if [ -n "$PGID" ]; then
        GROUP=$(getent group $PGID | cut -d: -f1)
        if [ -z $GROUP  ]; then
            echo "Creating group"
            addgroup -g $PGID group
            GROUP=group
        fi
    fi

    if [ -n "$PUID" ]; then
        USER=$(getent passwd $PUID | cut -d: -f1)
        if [ -z $USER ]; then
            echo "Creating user"
            if [ -n "$PGID" ]; then
                adduser --disabled-password --uid $PUID --ingroup group user
            else
                adduser --disabled-password --uid $PUID user
            fi
        fi
        USER=user
    else
        USER=nginx
    fi

    export LOG_FORMAT='$remote_addr - $remote_user [$time_local] "$request" $status $body_bytes_sent "$http_referer" "$http_user_agent" "$http_x_forwarded_for"'

    envsubst < /etc/nginx/nginx.template.conf > /etc/nginx/nginx.conf

    if [ -n $GROUP ]; then
        CAN_WRITE=$(s6-setuidgid $PUID:$PGID sh -c 'test -w /data && echo 1')
    else
        CAN_WRITE=$(s6-setuidgid $PUID sh -c 'test -w /data && echo 1')
    fi

    if [ -z $CAN_WRITE ]; then
        echo "Unable to write, setting chown"
        if [ -n $GROUP ]; then
            chown $USER:$GROUP /data
        else
            chown $USER /data
        fi
    fi

fi

echo "Start !"

exec nginx -g "daemon off;"
