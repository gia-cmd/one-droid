#!/system/bin/sh

# =============================================================================
# Gia - Ubuntu 20.04 armhf native starter 
# =============================================================================

export APP_DATA="/data/user/0/id.web.ewirs.gia/files/gia"
export UBUNTU_ROOT="$APP_DATA/ubuntu"
export HOME="$APP_DATA/home"               # ← lebih standar daripada gia/
export PATH="$UBUNTU_ROOT/usr/bin:$UBUNTU_ROOT/bin:$PATH"
export LD_LIBRARY_PATH="$UBUNTU_ROOT/lib:$UBUNTU_ROOT/usr/lib:$UBUNTU_ROOT/usr/lib/arm-linux-gnueabihf"

# Pastikan folder home ada
[ ! -d "$HOME" ] && mkdir -p "$HOME"

# Linker 32-bit armhf (penting!)
LINKER="$UBUNTU_ROOT/lib/ld-linux-armhf.so.3"

if [ ! -f "$LINKER" ] || [ ! -x "$LINKER" ]; then
    echo "Error: ld-linux-armhf.so.3 tidak ditemukan atau tidak bisa dieksekusi"
    echo "Lokasi yang dicari: $LINKER"
    exit 1
fi

if [ ! -f "$UBUNTU_ROOT/bin/bash" ] || [ ! -x "$UBUNTU_ROOT/bin/bash" ]; then
    echo "Error: bash tidak ditemukan di $UBUNTU_ROOT/bin/bash"
    exit 1
fi

# Optional: tambah resolv.conf agar DNS bekerja (jika ingin apt update nanti)
[ ! -f "$UBUNTU_ROOT/etc/resolv.conf" ] && {
    echo "nameserver 8.8.8.8" > "$UBUNTU_ROOT/etc/resolv.conf"
    echo "nameserver 1.1.1.1" >> "$UBUNTU_ROOT/etc/resolv.conf"
}

cd "$HOME" || exit 1

# Jalankan bash login shell menggunakan linker yang benar
exec "$LINKER" "$UBUNTU_ROOT/bin/bash" --login
