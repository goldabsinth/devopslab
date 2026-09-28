FROM debian
LABEL maintainer="goldabsinth"

RUN apt-get update && \
    apt-get install -y nginx && \
    rm -rf /var/lib/apt/lists/*

VOLUME "/var/www/html"
EXPOSE 80

CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
