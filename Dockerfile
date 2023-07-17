FROM mitmproxy/mitmproxy:9.0.1
RUN apt-get update && apt-get install -y procps
RUN pip3 install pyyaml

RUN mkdir -p /var/log/mitmproxy/
RUN touch /var/log/mitmproxy/mitm.log && chmod 776 /var/log/mitmproxy/mitm.log
RUN touch /var/log/mitmproxy/app.log && chmod 776 /var/log/mitmproxy/app.log
