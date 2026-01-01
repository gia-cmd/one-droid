#!/system/bin/sh

# Konfigurasi
PORT=8070
IP="127.0.0.1"

echo "Server berjalan di http://$IP:$PORT"
echo "Tekan [CTRL+C] untuk berhenti."

# Fungsi untuk menangani request
handle_request() {
    # Baca baris pertama (Method, Path, Protocol)
    read -r line <&3
    [ -z "$line" ] && return

    echo "Request: $line"

    # Isi Body HTML
    RESPONSE="<html>
<head><title>Bash Server</title></head>
<body>
    <h1>Hello dari Pure Bash!</h1>
    <p>Request kamu: <b>$line</b></p>
    <p>Waktu server: $(date)</p>
</body>
</html>"

    # Kirim Header dan Body ke file descriptor 3
    printf "HTTP/1.1 200 OK\r\n" >&3
    printf "Content-Type: text/html\r\n" >&3
    printf "Content-Length: %d\r\n" "${#RESPONSE}" >&3
    printf "Connection: close\r\n" >&3
    printf "\r\n" >&3
    printf "%s" "$RESPONSE" >&3
}

# Loop utama menggunakan 'exec' untuk membuka socket
# Menggunakan trik listen pada port tertentu
while true; do
    # Membuka koneksi melalui file descriptor 3
    # Catatan: Di banyak sistem modern, /dev/tcp hanya untuk CLIENT.
    # Untuk SERVER murni tanpa NC, kita butuh loopback atau bantuan 'read'
    
    exec 3<>/dev/tcp/$IP/$PORT 2>/dev/null
    
    if [ $? -ne 0 ]; then
        # Jika gagal (karena /dev/tcp biasanya bukan listener), 
        # kita butuh bantuan 'socat' atau 'nc'. 
        # TAPI, jika Anda di Linux yang mendukung 'loadables' bash:
        echo "Error: Bash /dev/tcp biasanya hanya untuk client-side."
        echo "Gunakan 'nc -l -p $PORT -e ./server.sh' jika ingin stabil."
        exit 1
    fi

    handle_request
    exec 3>&- # Tutup koneksi
done
