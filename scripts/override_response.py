# override_response.py
from mitmproxy import http

def response(flow: http.HTTPFlow) -> None:
    if flow.response.headers.get("content-type", "").startswith("text/html"):
        flow.response.content = flow.response.content.replace(b"</body>", b"<p>override</p></body>")
