#!/bin/bash
# run_chrome.sh
google-chrome-stable --headless --disable-gpu --screenshot --virtual-time-budget=5000 --no-sandbox --window-size=1280x1024 $1
