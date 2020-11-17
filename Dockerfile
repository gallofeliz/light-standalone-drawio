FROM alpine

RUN apk add --no-cache nginx-mod-http-dav-ext nginx gettext s6

EXPOSE 80

COPY nginx.conf /etc/nginx/nginx.template.conf

WORKDIR /app

COPY index.html run.sh ./

RUN chmod +x run.sh && rm /etc/nginx/nginx.conf

VOLUME /data

CMD ./run.sh
