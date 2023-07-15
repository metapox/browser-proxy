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
    gzpath = path + '.gz'
    index_path = os.path.join(path, 'index.html')
    index_gzpath = os.path.join(path, 'index.html.gz')

    matched_path = None
    is_gzipped = False

    # priority: path.gz > path > index.html.gz > index.html
    if os.path.isfile(gzpath):
        matched_path = gzpath
        is_gzipped = True
    elif os.path.isfile(path):
        matched_path = path
    elif os.path.isfile(index_gzpath):
        matched_path = index_gzpath
        is_gzipped = True
    elif os.path.isfile(index_path):
        matched_path = index_path

    if matched_path:
        logging.info('Override response for %s with %s', flow.request.pretty_url, matched_path)
        with open(matched_path, 'rb') as f:
            flow.response = http.Response.make(
                200,
                f.read(),
                { "content-type": "text/html;" }
            )
            if is_gzipped:
                flow.response.headers["content-encoding"] = "gzip"
