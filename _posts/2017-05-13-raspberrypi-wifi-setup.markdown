---
layout: post
title:  "A Note on RaspberryPi WiFi setup"
date:   2017-05-13 10:00:00 +0100
categories: DevOps
---

I like accessing my RaspberryPi's over SSH. This feature have been disabled for fresh installs of Raspbian, and for good reasons as well, to not provide a security breach into the Pi as many did without changing the default username and password.

It can also be a bit cumbersome to access your newly flashed Pi, especially if the plan is to run it headless without a keyboard/monitor attached.

### SSH access

After burning your SD card, and reading it as a mounted unit, the boot partition is accessible and writeable. To get SSH access straight away, add a file called `ssh` in the `boot` partition (most likely displayed as the root of your SD card).

[Official documentation](https://www.raspberrypi.org/documentation/remote-access/ssh/)

### WiFi Access

In the same manner as with the SSH file, a `wpa_supplicant.conf` file can be added to the `boot` partition, which will then be copied into `/etc/wpa_supplicant/wpa_supplicant.conf` to provide WiFi access when the Raspberry Pi has booted.

[Official documentation](https://www.raspberrypi.org/blog/another-update-raspbian/)
