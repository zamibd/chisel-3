// Example "smart" PAC: bypass local networks, proxy others.
function isInNetEx(ip, pattern, mask) { return isInNet(ip, pattern, mask); }

function FindProxyForURL(url, host) {
  if (isPlainHostName(host) ||
      shExpMatch(host, "*.local") ||
      isInNetEx(dnsResolve(host), "10.0.0.0", "255.0.0.0") ||
      isInNetEx(dnsResolve(host), "172.16.0.0", "255.240.0.0") ||
      isInNetEx(dnsResolve(host), "192.168.0.0", "255.255.0.0")) {
    return "DIRECT";
  }
  return "PROXY ${PUBLIC_HOST}:${CHISEL_PORT}; DIRECT";
}
