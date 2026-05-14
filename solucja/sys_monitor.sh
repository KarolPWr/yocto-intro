#!/bin/sh

LOGFILE="/var/log/cpu_stats.log"

echo "Rozpoczynam monitorowanie... Logi znajdziesz w: $LOGFILE"
echo "Naciśnij [CTRL+C], aby zatrzymać."

echo "--- Start monitoringu: $(date) ---" >> "$LOGFILE"

while true; do
    # 1. Pobranie daty i czasu
    TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

    # 2. Odczyt temperatury (wartość w sysfs jest w milistopniach, dzielimy przez 1000)
    # Zwykle thermal_zone0 to główny czujnik procesora
    RAW_TEMP=$(cat /sys/class/thermal/thermal_zone0/temp)
    TEMP_C=$(awk "BEGIN {print $RAW_TEMP/1000}")

    # 3. Odczyt taktowania CPU0 (wartość w kHz, przeliczamy na MHz)
    RAW_FREQ=$(cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_cur_freq)
    FREQ_MHZ=$(expr $RAW_FREQ / 1000)

    # 4. Uptime systemu
    UPTIME=$(uptime -p)

    # Złożenie wszystkiego w jeden wpis i zapis do pliku
    ENTRY="[$TIMESTAMP] Temp: ${TEMP_C}°C | Freq: ${FREQ_MHZ}MHz | $UPTIME"
    
    echo "$ENTRY" >> "$LOGFILE"

    # Opcjonalnie: wypisz też na ekran, żebyś widział, że działa
    echo "Zapisano: $ENTRY"

    # Czekaj 20 sekund
    sleep 20
done