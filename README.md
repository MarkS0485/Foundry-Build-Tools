# Foundry-Build-Tools

Complete mirror of the **Foundry / CoinGenerators** wallet build-farm dependency cache
(`depends-sources`) — the upstream source tarballs that coin `depends/` trees pin by URL.
Many of those upstream mirrors have rotted (404s / expired certs), so the build agents
resolve them from here instead, hash-verified against each package's `.mk` checksum.

## Layout

- **Source tarballs < 100MB** — committed directly in this repo (Qt, openssl, zlib, expat,
  nss, libevent, sqlite, and most boost/qt point releases, etc.).
- **Large packages > 100MB** — published as assets on the **`depends-cache`** GitHub Release
  (GitHub rejects files over 100MB in git). These are the big boost archives and the Rust
  toolchain.

## Get the full set

```bash
./get-depends.sh [dest-dir]
```

Clones the repo and downloads every release asset into the same directory, reconstituting
the complete cache. Public repo + release — no authentication needed.

All tarballs are unmodified upstream releases, kept here purely as a stable mirror. No warranty.
