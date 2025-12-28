#!/system/bin/sh

# Jalur absolut yang benar sesuai package name Anda
export APP_DATA="/data/user/0/id.web.ewirs.gia/files/gia"
export UBUNTU_DIR="$APP_DATA/ubuntu"
export HOME="$APP_DATA/gia"
export LINKER="$UBUNTU_DIR/lib/ld-linux-armhf.so.3"

# Setup Paths
export PATH="$UBUNTU_DIR/usr/bin:$UBUNTU_DIR/usr/sbin:$PATH"
export LD_LIBRARY_PATH="$UBUNTU_DIR/usr/lib:$UBUNTU_DIR/lib:$UBUNTU_DIR/usr/lib/arm-linux-gnueabihf"

# Buat folder jika belum ada
[ ! -d "$HOME" ] && mkdir -p "$HOME"

cd $HOME

# TANPA PROOT: Kita harus memanggil Bash Ubuntu melalui Linker-nya
# Cek apakah Bash Ubuntu tersedia
if [ -f "$UBUNTU_DIR/bin/bash" ]; then
    exec $LINKER $UBUNTU_DIR/bin/bash --login
else
    # Fallback ke sh Android jika bash belum ada
    exec /system/bin/sh -i
fi
