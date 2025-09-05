# === Stage 1: Build chisel binary ===
FROM golang:1.22-alpine AS builder

RUN apk add --no-cache git build-base

WORKDIR /src
RUN git clone --depth 1 https://github.com/jpillora/chisel.git

WORKDIR /src/chisel
RUN CGO_ENABLED=0 go build -trimpath -ldflags "-s -w" -o /out/chisel .

# === Stage 2: Minimal runtime image ===
FROM alpine:3.20

RUN adduser -D -H -s /sbin/nologin chisel

COPY --from=builder /out/chisel /usr/local/bin/chisel

USER chisel
EXPOSE 94

ENV CHISEL_AUTH=chiseluser:changeMe123!

ENTRYPOINT ["chisel", "server", "--auth", "${CHISEL_AUTH}", "--port", "94"]
