# Chisel + PAC – Full Deployable Package

This package includes:
- A Dockerfile to build **chisel server** from source (GitHub: jpillora/chisel)
- A Dockerfile to serve **PAC files** over HTTP (nginx)
- A `docker-compose.yml` to run both services together
- Example **client** helper scripts
- `.env.example` for ports/auth configuration

> NOTE: If you have specific "bugs" to fix in upstream chisel, open issues or provide details. This build pulls the latest upstream source and produces a reproducible image. You can pin a tag/commit by editing the Dockerfile clone step.

---

## 1) Configure

Copy the env template and edit values:

```bash
cp .env.example .env
nano .env
```

- `CHISEL_PORT` – server port (e.g., 94–99 as requested)
- `PAC_HTTP_PORT` – exposed PAC HTTP port (e.g., 95 or 96)
- `PUBLIC_HOST` – your public IP/hostname (used **inside PAC** files)
- `CHISEL_AUTH` – login in `user:pass` format

## 2) Build (optional) and Run

**Build locally** (so images use your Dockerfile code):

```bash
docker compose build
docker compose up -d
```

Or run without building (if you've already pushed to Docker Hub and replaced `YOUR_DOCKERHUB_USERNAME/...` in compose):

```bash
docker compose up -d
```

Check status:

```bash
docker ps
```

## 3) Push to Docker Hub

Login and push images built from the Dockerfiles:

```bash
# Replace with your Docker Hub username
export DH=YOUR_DOCKERHUB_USERNAME

# Build & tag
docker build -t $DH/chisel-server:latest ./server
docker build -t $DH/pac-server:latest ./pac

# Push
docker push $DH/chisel-server:latest
docker push $DH/pac-server:latest
```

Then update `docker-compose.yml` images accordingly (they are pre-filled with placeholders).

## 4) Client Usage (example)

On a client machine, download the chisel binary matching your OS/arch, then:

```bash
# SOCKS proxy on localhost (some chisel builds support `socks` mode)
./chisel client --auth user:pass <PUBLIC_IP>:<CHISEL_PORT> socks
```

Then set your OS/app to use SOCKS5 proxy at `127.0.0.1:1080`.
Alternatively, point your system/browser to the PAC URL:

```
http://<PUBLIC_IP>:<PAC_HTTP_PORT>/proxy-all.pac
```

or

```
http://<PUBLIC_IP>:<PAC_HTTP_PORT>/smart.pac
```

> PAC files here are simple examples that point traffic to `<PUBLIC_HOST>:<CHISEL_PORT>`. Adjust for your environment if you prefer using a local proxy.

## 5) Notes & Recommendations

- To **pin chisel version**, edit `server/Dockerfile` and replace the `git clone` with a specific tag/commit.
- If you have **custom patches** for chisel, add them in `server/` and modify the Dockerfile build steps accordingly.
- For production, consider persisting server keys and enabling logs/mount volumes as needed.
- The `CHISEL_EXTRA_ARGS` env lets you pass additional flags to `chisel server` without rebuilding.

## 6) Clean Up

```bash
docker compose down
docker image prune -f
```

---

**Security**: Change default credentials and restrict access via firewall as needed.
