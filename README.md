# MyGica / Geniatech A681 DKMS driver

This package targets only USB ID `1f4d:a681`, the CY7C68013/MN88436/MxL603
A681. It supports ATSC 1.0 8-VSB and clear QAM (64/256); it does not support
ATSC 3.0. It deliberately installs `mygica_a681.ko`, leaving the distro
`dvb-usb-cxusb` module untouched.

I couldn’t find a maintained driver for the MyGica/Geniatech A681 USB TV Tuner on current Linux kernels, so I created this DKMS-based port with assistance from Codex. It was developed and verified on a Raspberry Pi 5 running Raspberry Pi OS 64-bit with kernel 6.12.75+rpt-rpi-2712.
Also verified on Debian 13 / x86_64, kernel 6.12.86+deb13-amd64.


## Build and install

Install the packages needed to build DKMS kernel modules:

```sh
sudo apt update
sudo apt install dkms build-essential linux-headers-$(uname -r)
```

Run `sudo ./install-dkms.sh`. The installer creates `/usr/src/mygica-a681-0.1.0`, registers it with DKMS, builds it for the running kernel, installs it, and runs `depmod`.

Run `sudo ./uninstall-dkms.sh` to remove the registered DKMS package.


## Validation

After reconnecting the tuner, confirm `mygica_a681` is bound and
`/dev/dvb/adapter*/frontend0` exists. Use `dmesg -w` during reconnect. An RF
signal is required to validate a lock and transport-stream capture.


## Using the tuner with NextPVR

These steps assume this DKMS driver is already installed and the A681 has been
unplugged and reconnected.

1. Confirm Linux can see the tuner:

   ```sh
   ls /dev/dvb/adapter*/frontend0
   dmesg | grep -i mygica
   ```

   If no frontend appears, reconnect the tuner and check `dmesg -w` for driver
   messages before continuing.

2. Install NextPVR from the Linux `.deb` helper package:

   ```sh
   curl https://nextpvr.com/nextpvr-helper.deb -O
   sudo apt install ./nextpvr-helper.deb --install-recommends
   ```

   Wait about 30 seconds for the service to start.

3. Open the NextPVR web app:

   ```text
   http://127.0.0.1:8866
   ```

   The default login is `admin` / `password`.

4. Go to `Settings` -> `Devices`. The A681 should appear as a DVB/ATSC tuner.
   Select the device, choose the tuner type for your signal, then scan:

   - Use `ATSC` for over-the-air antenna channels in North America.
      - I used us-ATSC-center-frequencies-8VSB
   - Use `QAM` only for unencrypted cable channels.

5. Save the channels found by the scan, then test one from `Live TV`. After that
   you can add guide data and set up recordings from the NextPVR interface.

NextPVR's Linux install notes are maintained at
<https://forums.nextpvr.com/showthread.php?tid=59390>.
