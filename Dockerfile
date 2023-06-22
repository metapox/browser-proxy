FROM mitmproxy/mitmproxy:9.0.1
RUN apt-get update && apt-get install -y procps
