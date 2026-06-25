# MyGica / Geniatech A681 DKMS driver

This package targets only USB ID `1f4d:a681`, the CY7C68013/MN88436/MxL603
A681. It supports ATSC 1.0 8-VSB and clear QAM (64/256); it does not support
ATSC 3.0. It deliberately installs `mygica_a681.ko`, leaving the distro
`dvb-usb-cxusb` module untouched.

I couldn’t find a maintained driver for the MyGica/Geniatech A681 USB TV Tuner on current Linux kernels, so I created this DKMS-based port with assistance from Codex. It was developed and verified on a Raspberry Pi 5 running Raspberry Pi OS 64-bit with kernel 6.12.75+rpt-rpi-2712.
Also verified on Debian 13 / x86_64, kernel 6.12.86+deb13-amd64.


## Build and install

Run `sudo ./install-dkms.sh`. The installer creates `/usr/src/mygica-a681-0.1.0`, registers it with DKMS, builds it for the running kernel, installs it, and runs `depmod`.

Run `sudo ./uninstall-dkms.sh` to remove the registered DKMS package.

## Firmware

The driver requires `dvb-demod-mn88436-01.fw`. No firmware blob is included.
Obtain it from a source authorized to distribute it, then run:

```
sudo ./install-firmware.sh /path/to/dvb-demod-mn88436-01.fw SHA256
```

The script verifies the filename and exact SHA-256 checksum before copying it
to `/lib/firmware`.

## Validation

After reconnecting the tuner, confirm `mygica_a681` is bound and
`/dev/dvb/adapter*/frontend0` exists. Use `dmesg -w` during reconnect. An RF
signal is required to validate a lock and transport-stream capture.
