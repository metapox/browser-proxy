from mitmproxy import http
from urllib.parse import urlparse
import os
import logging
import yaml

base_dir = '/home/mitmproxy/override-files/'

script_dir = os.path.dirname(os.path.realpath(__file__))
config_path = os.path.join(script_dir, 'config.yaml')

with open(config_path, 'r') as stream:
  try:
    data = yaml.safe_load(stream)
  except yaml.YAMLError as exc:
    print(exc)

def response(flow: http.HTTPFlow) -> None:
  url = urlparse(flow.request.pretty_url)
  path = os.path.join(url.netloc, url.path.lstrip('/'))

  if (path in data['targets']):
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
