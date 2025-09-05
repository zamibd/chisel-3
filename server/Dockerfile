# --- Build chisel from source ---
FROM golang:1.22-alpine AS builder
RUN apk add --no-cache git build-base
WORKDIR /src
RUN git clone --depth 1 https://github.com/jpillora/chisel.git
WORKDIR /src/chisel
RUN CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /out/chisel ./cmd/chisel

# --- Minimal runtime image ---
FROM alpine:3.20
RUN adduser -D -H -s /sbin/nologin chisel
COPY --from=builder /out/chisel /usr/local/bin/chisel
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV CHISEL_PORT=95     CHISEL_AUTH=     CHISEL_EXTRA_ARGS=

EXPOSE 95/tcp
USER chisel
ENTRYPOINT ["/entrypoint.sh"]
