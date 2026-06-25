#!/bin/sh
set -eu

name=mygica-a681
version=0.1.0
source_dir=/usr/src/$name-$version

test "$(id -u)" -eq 0 || { echo "run as root" >&2; exit 1; }
rm -rf "$source_dir"
install -d "$source_dir"
cp -a . "$source_dir/"
dkms remove -m "$name" -v "$version" --all 2>/dev/null || true
dkms add -m "$name" -v "$version"
dkms build -m "$name" -v "$version" -k "$(uname -r)"
dkms install -m "$name" -v "$version" -k "$(uname -r)"
depmod -a "$(uname -r)"
