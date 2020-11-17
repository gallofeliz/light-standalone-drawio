FROM alpine

RUN apk add --no-cache nginx-mod-http-dav-ext nginx gettext

EXPOSE 80

COPY nginx.conf /etc/nginx/nginx.conf

WORKDIR /app

COPY index.html empty.xml run.sh ./

RUN chmod +x run.sh

VOLUME /data

CMD ./run.sh
