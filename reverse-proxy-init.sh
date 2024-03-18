#!/bin/bash

# Install Nginx
apt-get update
apt-get install -y nginx

# Remove old default configuration
rm -f /etc/nginx/sites-available/default

# Create new default configuration to listen on port 80 and forward requests to the app
cat << EOF > /etc/nginx/sites-available/default
server {
  listen        80 default_server;
  location / {
    proxy_pass         http://10.0.0.7:3000/;
    proxy_http_version 1.1;
    proxy_set_header   Upgrade \$http_upgrade;
    proxy_set_header   Connection keep-alive;
    proxy_set_header   Host \$host;
    proxy_cache_bypass \$http_upgrade;
    proxy_set_header   X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header   X-Forwarded-Proto \$scheme;
  }
}
EOF

nginx -t
systemctl reload nginx