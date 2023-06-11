#!/bin/bash
# run_chrome.sh
proxy_server="mitmproxy" # あなたのプロキシサーバのアドレス
proxy_port="8080"     # あなたのプロキシサーバのポート

google-chrome-stable --headless \
                     --disable-gpu \
                     --virtual-time-budget=5000 \
                     --no-sandbox \
                     --proxy-server="$proxy_server:$proxy_port" \
                     $1
