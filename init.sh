#!/bin/bash
SERVERNAME=${SERVERNAME:-example.com}
JENKINS_HOME=${JENKINS_HOME:-/var/lib/jenkins}
UPSTREAM_PROTO=${UPSTREAM_PROTO:-http}
UPSTREAM_HOST=${UPSTREAM_HOST:-localhost}
UPSTREAM_PORT=${UPSTREAM_PORT:-8080}


echo "Configuring Nginx Reverse Proxy..."

sed -i -e "s|_SERVER_NAME_|$SERVERNAME|g" /etc/nginx/conf.d/default.conf
sed -i -e "s|_JENKINS_HOME_|$JENKINS_HOME|g" /etc/nginx/conf.d/default.conf
#sed -i "s|_UPSTREAM_PROTO_|$UPSTREAM_PROTO|g" /etc/nginx/conf.d/default.conf
sed -i -e "s|_UPSTREAM_HOST_|$UPSTREAM_HOST|g" /etc/nginx/conf.d/default.conf
sed -i -e "s|_UPSTREAM_PORT_|$UPSTREAM_PORT|g" /etc/nginx/conf.d/default.conf

echo "Starting Nginx Reverse Proxy..."
# Echo error/access log to stdout
tailf /var/log/nginx/access.log &
tailf /var/log/nginx/error.log &

# Start nginx in the foreground
nginx
