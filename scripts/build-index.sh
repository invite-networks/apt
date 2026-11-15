#!/bin/sh
# Builds an unsigned apt repository in the given directory from pool/.
#   scripts/build-index.sh <out-dir>
set -eu
out=${1:?usage: build-index.sh <out-dir>}
suite=stable
archs="amd64 arm64"
rm -rf "$out"
mkdir -p "$out"
cp -R pool "$out/pool"
cp invite-networks.asc index.html "$out/"
cd "$out"
for arch in $archs; do
  dir=dists/$suite/main/binary-$arch
  mkdir -p "$dir"
  apt-ftparchive --arch "$arch" packages pool > "$dir/Packages"
  gzip -9kn "$dir/Packages"
  xz -kf "$dir/Packages"
done
apt-ftparchive \
  -o APT::FTPArchive::Release::Origin="INVITE Networks" \
  -o APT::FTPArchive::Release::Label="INVITE Networks" \
  -o APT::FTPArchive::Release::Suite="$suite" \
  -o APT::FTPArchive::Release::Codename="$suite" \
  -o APT::FTPArchive::Release::Architectures="$archs" \
  -o APT::FTPArchive::Release::Components="main" \
  -o APT::FTPArchive::Release::Description="INVITE Networks packages" \
  release "dists/$suite" > Release.tmp
mv Release.tmp "dists/$suite/Release"
