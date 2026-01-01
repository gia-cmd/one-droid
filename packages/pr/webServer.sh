#!/system/bin/sh

# Konfigurasi
PORT=8080
DEV_PATH="/sdcard/media/ewies/portos/public" # Sesuaikan dengan path custom Anda

echo "Server berjalan di port $PORT..."

while true; do
  # Menggunakan exec untuk membuka file descriptor (FD) 3 ke soket
  # Note: Bash original menggunakan /dev/tcp/host/port
  exec 3<>$DEV_PATH

  # Membaca request dari client (baris pertama biasanya: GET / HTTP/1.1)
  read -u 3 line
  
  # Ambil path yang diminta (misal: /index.html)
  REQUEST_PATH=$(echo $line | cut -d' ' -f2)
  echo "Request masuk: $line"

  # Logika Response
  RESPONSE="<html><body><h1>Hello dari Pure Bash!</h1><p>Anda mengakses: $REQUEST_PATH</p></body></html>"
  
  # Mengirim HTTP Header
  echo -e "HTTP/1.1 200 OK" >&3
  echo -e "Content-Type: text/html" >&3
  echo -e "Content-Length: ${#RESPONSE}" >&3
  echo -e "Connection: close" >&3
  echo -e "" >&3
  
  # Mengirim Body
  echo -e "$RESPONSE" >&3

  # Tutup koneksi agar browser berhenti loading
  exec 3>&-
done
