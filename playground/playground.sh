#!/system/bin/sh

UBUNTU_ROOT="/data/user/0/id.web.ewirs.gia/files/ubuntu"
HOME_DIR="/data/user/0/id.web.ewirs.gia/files/gia"
[ ! -d "$HOME_DIR" ] && mkdir -p "$HOME_DIR"

unset LD_PRELOAD

proot --link2symlink \
  -0 \
  -r "$UBUNTU_ROOT" \
  -b /dev \
  -b /proc \
  -b /sys \
  -b /storage/emulated/0:/sdcard \
  -w "$HOME_DIR" \
  -b "$UBUNTU_ROOT/etc/resolv.conf:/etc/resolv.conf" \
  /usr/bin/env -i \
  HOME="$HOME_DIR" \
  PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin" \
  TERM="$TERM" \
  /bin/bash --login