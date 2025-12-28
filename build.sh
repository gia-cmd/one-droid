#!/system/bin/sh


export APP_DATA="/data/user/0/id.web.ewirs.gia/files/gia"
export UBUNTU_DIR="$APP_DATA/ubuntu"


export PATH="$UBUNTU_DIR/usr/bin:$UBUNTU_DIR/usr/sbin:$PATH"

export LD_LIBRARY_PATH="$UBUNTU_DIR/usr/lib:$UBUNTU_DIR/lib:$UBUNTU_DIR/usr/lib/arm-linux-gnueabihf"


export HOME="$APP_DATA/gia"
export TMPDIR="$APP_DATA/tmp"

if [ ! -d "$HOME" ]; then mkdir -p "$HOME"; fi
if [ ! -d "$TMPDIR" ]; then mkdir -p "$TMPDIR"; fi

cd $HOME
see /system/bin/sh -i
