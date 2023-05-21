sudo cp ../mitmproxy-keys/mitmproxy-ca-cert.pem /etc/pki/ca-trust/source/anchors/
sudo cp ../mitmproxy-keys/mitmproxy-ca-cert.pem /usr/local/share/ca-certificates/
sudo update-ca-trust
