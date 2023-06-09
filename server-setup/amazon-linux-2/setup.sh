#!/bin/bash

# Install mitmproxy
yum install -y python3 python3-pip procps git
pip3 install mitmproxy

# making log dir
mkdir -p /var/log/mitmproxy/
touch /var/log/mitmproxy/mitmproxy.log
touch /var/log/mitmproxy/app.log

git clone https://github.com/metapox/browser-proxy.git /home/mitmproxy
cd /home/mitmproxy/
conf_dir=$(pwd)/server-setup/amazon-linux-2

# logrotate
systemctl crond start
cp $conf_dir/logrotate.conf /etc/logrotate.d/mitmproxy

# mitmproxy.service
sudo systemctl daemon-reload
cp $conf_dir/mitmproxy.service /etc/systemd/system/mitmproxy.service
sudo systemctl enable mitmproxy
sudo systemctl start mitmproxy
