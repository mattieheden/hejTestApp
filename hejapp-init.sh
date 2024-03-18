#!/bin/bash

# Variables
appName=hejTestApp
appPort=3000

# Install Microsoft package & dotnet runtime 8.0

wget https://packages.microsoft.com/config/ubuntu/22.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb

dpkg -i packages-microsoft-prod.deb

rm -f packages-microsoft-prod.deb

apt update

apt-get update && apt-get install -y aspnetcore-runtime-8.0

# Write service file & create opt directory

mkdir -p /opt/$appName

cat << EOF > /etc/systemd/system/$appName.service
[Unit]
Description=$appName is a simple webapp.

[Service]
WorkingDirectory=/opt/$appName
ExecStart=/usr/bin/dotnet /opt/$appName/$appName.dll
Restart=always
RestartSec=10
KillSignal=SIGINT
SyslogIdentifier=$appName
User=www-data
EnvironmentFile=/etc/default/$appName

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable $appName.service


