// Proxy ALL traffic via the HTTP proxy the user configures on their device.
// Typically, you'll run a chisel *client* locally to expose an HTTP/SOCKS proxy.
// This PAC file is provided as a placeholder reference.
function FindProxyForURL(url, host) {
  return "PROXY ${PUBLIC_HOST}:${CHISEL_PORT}; DIRECT";
}
