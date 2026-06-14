# Foundry-Build-Tools

Staged upstream source tarballs for the **Foundry / CoinGenerators** cryptocurrency-wallet build farm.

Older coin `depends/` trees pin certain build dependencies by URL, and many of those upstream
mirrors have rotted (404s / expired certificates). The build agents resolve them from this
repository instead (their `SOURCES_PATH` / `depends-sources` cache), hash-verified against each
package's `.mk` checksum.

## Contents

| Package | Versions |
|---|---|
| Qt `qtbase` | 5.6.1, 5.7.1, 5.9.6, 5.12.11 |
| Qt `qttools` | 5.6.1, 5.7.1, 5.9.6, 5.12.11 |
| Qt `qttranslations` | 5.6.1, 5.7.1, 5.9.6, 5.12.11 |
| `zlib` | 1.2.13, 1.3 |
| `expat` | 2.2.0, 2.6.2 |

All tarballs are unmodified upstream releases, kept here purely as a stable mirror. No warranty.
