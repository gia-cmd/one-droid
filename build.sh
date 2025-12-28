#!/system/bin/sh


export APP_DATA="/data/user/0/onegiaterm.ewirs.web.id/files/gia"
export UBUNTU_DIR="$APP_DATA/cupy"


export PATH="$UBUNTU_DIR/usr/bin:$UBUNTU_DIR/usr/sbin:$PATH"

export LD_LIBRARY_PATH="$UBUNTU_DIR/usr/lib:$UBUNTU_DIR/lib:$UBUNTU_DIR/usr/lib/arm-linux-gnueabihf"


export HOME="$APP_DATA/home"
export TMPDIR="$APP_DATA/tmp"

if [ ! -d "$HOME" ]; then mkdir -p "$HOME"; fi
if [ ! -d "$TMPDIR" ]; then mkdir -p "$TMPDIR"; fi

cd $HOME
exec /system/bin/sh -i
