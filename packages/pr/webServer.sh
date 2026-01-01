#!/system/bin/sh
# Pure sh HTTP-like "server" menggunakan NAMED PIPE (FIFO) - hanya lokal/debug
# Bukan TCP server sungguhan → hanya simulasi request-response via pipe

# Konfigurasi
PORT=8070                  # hanya untuk tampilan (tidak benar-benar dipakai)
DEV_PATH="/data/user/0/id.web.ewirs.gia/files"
FIFO_IN="$DEV_PATH/http-in.pipe"
FIFO_OUT="$DEV_PATH/http-out.pipe"

echo "Memulai pseudo-server di direktori: $DEV_PATH"
echo "(Hanya lokal - bukan TCP server sungguhan)"
echo "Gunakan: echo 'GET /tes' > $FIFO_IN"
echo "Lihat respons di: cat $FIFO_OUT"
echo ""

# Buat named pipes jika belum ada
[ -p "$FIFO_IN" ]  || mkfifo "$FIFO_IN"  2>/dev/null
[ -p "$FIFO_OUT" ] || mkfifo "$FIFO_OUT" 2>/dev/null

# Pastikan permission (jika root atau punya akses)
chmod 600 "$FIFO_IN" "$FIFO_OUT" 2>/dev/null

echo "Pseudo-server siap. Tekan Ctrl+C untuk stop."

while true; do
    # Baca request dari FIFO (blocking sampai ada yang menulis ke FIFO_IN)
    read -r line < "$FIFO_IN"

    if [ -z "$line" ]; then
        # kosong → lanjut loop
        continue
    fi

    echo "Request masuk: $line"

    # Ambil path sederhana (contoh: GET /halo HTTP/1.1 → /halo)
    REQUEST_PATH=$(echo "$line" | cut -d' ' -f2 2>/dev/null)
    [ -z "$REQUEST_PATH" ] && REQUEST_PATH="/"

    # Buat response HTML sederhana
    RESPONSE="<html><head><title>Pseudo Server</title></head>
<body>
<h1>Hello dari Pure Shell!</h1>
<p>Request path: <strong>$REQUEST_PATH</strong></p>
<p>Waktu: $(date '+%Y-%m-%d %H:%M:%S')</p>
<hr>
<small>Server berjalan di $DEV_PATH (FIFO mode)</small>
</body></html>"

    # Hitung panjang content
    CONTENT_LENGTH=$(echo -n "$RESPONSE" | wc -c 2>/dev/null || echo ${#RESPONSE})

    # Kirim response ke FIFO_OUT (dalam format HTTP sederhana)
    {
        echo "HTTP/1.1 200 OK"
        echo "Content-Type: text/html"
        echo "Content-Length: $CONTENT_LENGTH"
        echo "Connection: close"
        echo ""
        echo "$RESPONSE"
    } > "$FIFO_OUT"

    # Optional: log ke stderr juga
    echo "Response dikirim ke $FIFO_OUT (panjang: $CONTENT_LENGTH bytes)"
done
