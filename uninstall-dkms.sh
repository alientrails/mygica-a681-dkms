#!/bin/sh
set -eu

name=mygica-a681
version=0.1.0
test "$(id -u)" -eq 0 || { echo "run as root" >&2; exit 1; }
dkms remove -m "$name" -v "$version" --all
rm -rf "/usr/src/$name-$version"
depmod -a "$(uname -r)"
