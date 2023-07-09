from mitmproxy import http
from urllib.parse import urlparse
import os
import logging

log_file = '/var/log/mitmproxy/app.log'
base_dir = '/home/mitmproxy/override-files/'

logging.basicConfig(filename=log_file, level=logging.INFO)

def response(flow: http.HTTPFlow) -> None:
    url = urlparse(flow.request.pretty_url)
    path = os.path.join(base_dir, url.netloc, url.path.strip('/'))

    if os.path.isfile(path):
        logging.info('Override response for %s', flow.request.pretty_url)
        with open(path, 'r') as f:
            flow.response = http.HTTPResponse.make(
                200,
                f.read(),
                {"Content-Type": "text/html"}
            )
