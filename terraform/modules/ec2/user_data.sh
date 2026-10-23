#!/bin/bash

dnf install -y python3

mkdir -p /opt/app

cat > /opt/app/server.py <<'PYEOF'
from http.server import BaseHTTPRequestHandler, HTTPServer

class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.send_header("Content-type", "text/plain")
        self.end_headers()
        self.wfile.write(b"Hello from private EC2 behind ALB")

    def log_message(self, format, *args):
        pass

server = HTTPServer(("0.0.0.0", 8080), Handler)
server.serve_forever()
PYEOF

nohup python3 /opt/app/server.py > /opt/app/server.log 2>&1 &
