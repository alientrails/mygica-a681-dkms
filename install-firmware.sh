#!/bin/sh
set -eu

firmware=${1:?usage: install-firmware.sh PATH SHA256}
expected=${2:?usage: install-firmware.sh PATH SHA256}
name=dvb-demod-mn88436-01.fw

test "$(id -u)" -eq 0 || { echo "run as root" >&2; exit 1; }
test "$(basename "$firmware")" = "$name" || {
  echo "expected firmware filename: $name" >&2
  exit 1
}
actual=$(sha256sum "$firmware" | awk '{print $1}')
test "$actual" = "$expected" || { echo "SHA-256 mismatch" >&2; exit 1; }
install -D -m 0644 "$firmware" "/lib/firmware/$name"
