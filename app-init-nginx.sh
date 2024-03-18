#!/bin/bash

# Test script..
# Install Nginx
apt-get update
apt-get install -y nginx

# Remove default test page
rm -f /var/www/html/index.nginx-debian.html

# Create new default page
cat << EOF > /var/www/html/index.nginx-debian.html
<!DOCTYPE html>
<html>
  <head>
    <title>Hej Appserver!</title>
  </head>
  <body>
    <h1>Hej Appserver!</h1>
  </body>
</html>
EOF

nginx -t
systemctl reload nginx
