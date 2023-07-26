#!/bin/bash -e

# sudo su -
# curl  -OL https://raw.githubusercontent.com/metapox/browser-proxy/main/server-setup/amazon-linux-2/setup.sh
# chmod +x setup.sh

# python version
PYTHON_VERSION=3.11.2

# Install mitmproxy
yum upgrade -y
yum remove -y openssl-devel
yum install -y openssl11 openssl11-devel
yum install -y gcc make zlib-devel bzip2 bzip2-devel readline-devel sqlite sqlite-devel tk-devel libffi-devel xz-devel procps git wget tar gzip
git clone https://github.com/pyenv/pyenv.git ~/.pyenv
cd ~/
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc
echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
source ~/.bashrc
pyenv install $PYTHON_VERSION
pyenv global $PYTHON_VERSION
pip install --upgrade pip
pip install mitmproxy==9.0.1 pyyaml

# making log dir
mkdir -p /var/log/mitmproxy/
touch /var/log/mitmproxy/mitmproxy.log
touch /var/log/mitmproxy/app.log

git clone https://github.com/metapox/browser-proxy.git /home/mitmproxy
cd /home/mitmproxy/
conf_dir=$(pwd)/server-setup/amazon-linux-2

# logrotate
# systemctl crond start
# cp -f $conf_dir/logrotate.conf /etc/logrotate.d/mitmproxy

# mitmproxy.service
systemctl daemon-reload
cp -f $conf_dir/mitmproxy.service /etc/systemd/system/mitmproxy.service
systemctl enable mitmproxy
systemctl start mitmproxy
