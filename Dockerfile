FROM nginx:1.9.6
MAINTAINER Steven Wirges stevenwirges@gmail.com

# Nginx fix for very long server names
RUN sed -i 's/^http {/&\n    server_names_hash_bucket_size 128;/g' /etc/nginx/nginx.conf
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

RUN mkdir /etc/nginx/partials && mkdir /etc/nginx/certs && mkdir /etc/nginx/htpasswd && rm /etc/nginx/conf.d/default.conf


VOLUME ["/etc/nginx/certs","/etc/nginx/htpasswd"]

ADD dhparam2048.pem /etc/nginx/

COPY default.conf /etc/nginx/conf.d/
COPY auth.conf /etc/nginx/

COPY init.sh .

ENTRYPOINT ["./init.sh"]
