#!/bin/bash -e

start() {
    echo "Starting process..."
    mitmdump -p 9090 -s /home/mitmproxy/scripts/save_file/save_file.py --ssl-insecure --mode regular > /var/log/mitmproxy/save_file.log &
}

stop() {
    echo "Stopping process"
    pkill -f "mitmdump -p 9090 -s /home/mitmproxy/scripts/override_response.py --ssl-insecure --mode regular"
    echo "Done"
}

restart() {
    echo "Restarting process..."
    stop
    start
}

cas "$1" in
    start)   start ;;
    stop)    stop ;;
    restart) restart ;;
    *) echo "usage: $0 start|stop|restart" >&2
       exit 1
       ;;
esac
