#!/bin/bash -e

start() {
    echo "Starting process..."
    mitmdump -s /home/mitmproxy/scripts/override_response.py --ssl-insecure --mode regular > /var/log/mitmproxy/mitm.log
}

stop() {
    echo "Stopping process"
    pkill -f "mitmdump -s /home/mitmproxy/scripts/override_response.py --ssl-insecure --mode regular"
    echo "Done"
}

restart() {
    echo "Restarting process..."
    stop
    start
}

case "$1" in
    start)   start ;;
    stop)    stop ;;
    restart) restart ;;
    *) echo "usage: $0 start|stop|restart" >&2
       exit 1
       ;;
esac
