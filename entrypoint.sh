#!/bin/sh
set -e
PORT="${PORT:-8080}"
UUID="${UUID:-}"
if [ -z "$UUID" ]; then
  echo "ERROR: UUID env var is not set" >&2
  exit 1
fi
mkdir -p /etc/sing-box
cat > /etc/sing-box/config.json <<EOF
{
  "log": {"level": "info"},
  "inbounds": [
    {
      "type": "vless",
      "listen": "0.0.0.0",
      "listen_port": $PORT,
      "users": [{"uuid": "$UUID"}],
      "transport": {"type": "ws", "path": "/vless"}
    }
  ],
  "outbounds": [{"type": "direct"}]
}
EOF
exec /usr/local/bin/sing-box run -c /etc/sing-box/config.json
