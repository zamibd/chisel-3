#!/bin/sh
set -e

PORT="${CHISEL_PORT:-95}"
AUTH_ARG=""

if [ -n "$CHISEL_AUTH" ]; then
  AUTH_ARG="--auth ${CHISEL_AUTH}"
fi

echo "[chisel] starting server on port ${PORT}"
exec /usr/local/bin/chisel server --port "${PORT}" ${AUTH_ARG} ${CHISEL_EXTRA_ARGS}
