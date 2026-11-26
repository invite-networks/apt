# INVITE Networks apt repository

Signed Debian and Ubuntu packages for INVITE Networks open source projects,
published at <https://invite-networks.github.io/apt>.

## Use it

Supported: Debian 12 and later, Ubuntu 22.04 and later, on amd64 and arm64.

```sh
sudo install -d -m 0755 /etc/apt/keyrings
curl -fsSL https://invite-networks.github.io/apt/invite-networks.asc |
  sudo tee /etc/apt/keyrings/invite-networks.asc >/dev/null
sudo tee /etc/apt/sources.list.d/invite-networks.sources >/dev/null <<'SRC'
Types: deb
URIs: https://invite-networks.github.io/apt
Suites: stable
Components: main
Signed-By: /etc/apt/keyrings/invite-networks.asc
SRC
sudo apt update
sudo apt install gantry
```

## Packages

| Package | Source |
|---|---|
| gantry | [invite-networks/gantry](https://github.com/invite-networks/gantry) |
| gantry-nautobot | [invite-networks/gantry-nautobot](https://github.com/invite-networks/gantry-nautobot) |
| kanidm-unixd, libnss-kanidm, libpam-kanidm | Upstream [Kanidm](https://github.com/kanidm/kanidm) client, built for Debian 13 by the `kanidm-client-debs` workflow in invite-networks/ansible-linux |

## How it works

Each project's release workflow builds its `.deb` files and commits them to
`pool/main/`. A push to `main` runs `.github/workflows/publish.yml`, which
builds the index with `scripts/build-index.sh`, signs it with the key in the
`APT_SIGNING_KEY` secret, and deploys the result to GitHub Pages. Only the
packages live in git; the index and signatures are rebuilt on every publish.

The public signing key is `invite-networks.asc` in this repository, fingerprint
`5003 3748 874F 6290 4010  C4BD 8E9A 07F7 10EE A277` (ed25519, expires
2029-11-14; it will be extended before then).
