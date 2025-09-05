#!/usr/bin/env bash
set -euo pipefail
SERVER_HOST="${SERVER_HOST:-146.190.86.183}"
SERVER_PORT="${SERVER_PORT:-95}"
AUTH="${AUTH:-test:test123}"

echo "Starting chisel client (SOCKS5 on 127.0.0.1:1080)..."
./chisel client --auth "${AUTH}" "${SERVER_HOST}:${SERVER_PORT}" socks
