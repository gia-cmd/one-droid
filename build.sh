#!/system/bin/sh

export UBUNTU_DIR="/cupy/"
export PATH="$UBUNTU_DIR/usr/bin:$UBUNTU_DIR/usr/sbin:$PATH"
export LD_LIBRARY_PATH="$UBUNTU_DIR/usr/lib:$UBUNTU_DIR/lib"
export HOME="/cupy/root"
export TMPDIR="/tmp"

cd $HOME
exec /system/bin/sh -i
