@echo off
REM Example Windows client start (requires chisel.exe in same folder)
set SERVER_HOST=146.190.86.183
set SERVER_PORT=95
set AUTH=test:test123

echo Starting chisel client (SOCKS5 on 127.0.0.1:1080)...
chisel.exe client --auth %AUTH% %SERVER_HOST%:%SERVER_PORT% socks
