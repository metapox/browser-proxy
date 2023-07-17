from mitmproxy import http
from urllib.parse import urlparse
import os
import logging

base_dir = '/home/mitmproxy/override-files/'
targets = [
]

def response(flow: http.HTTPFlow) -> None:
  url = urlparse(flow.request.pretty_url)
  path = os.path.join(url.netloc, url.path.lstrip('/'))

  if (path in targets):
    path = os.path.join(base_dir, path)

    if (path[len(path) - 1] == '/'):
      path = os.path.join(path, 'index.html')

    logging.info('Saving file: ' + path)
    os.makedirs(os.path.dirname(path), exist_ok=True)

    with open(path, 'w') as f:
      if isinstance(flow.response.content, bytes):
        content = flow.response.content.decode('utf-8')
      else:
        content = flow.response.content
      f.write(content)
