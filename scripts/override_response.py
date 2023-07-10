from mitmproxy import http
from urllib.parse import urlparse
import os
import logging
import gzip

log_file = '/var/log/mitmproxy/app.log'
base_dir = '/home/mitmproxy/override-files/'

logging.basicConfig(filename=log_file, level=logging.INFO)

def response(flow: http.HTTPFlow) -> None:
    url = urlparse(flow.request.pretty_url)
    path = os.path.join(base_dir, url.netloc, url.path.strip('/'))
    index_path = os.path.join(path, 'index.html')
    matched_path = None

    if os.path.isfile(path):
        matched_path = path
    elif os.path.isfile(index_path):
        matched_path = index_path

    # TODO check request headers for accept-encoding
    if matched_path:
        logging.info('Override response for %s', flow.request.pretty_url)
        with open(matched_path, 'r') as f:
            flow.response = http.Response.make(
                200,
                gzip.compress(f.read()),
                {
                    "Content-Type": "text/html; charset=UTF-8",
                    "Content-Encoding": "gzip"
                }
            )
