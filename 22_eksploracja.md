# Eksploracja systemu

## Komunikacja z płytką

### UART

UART jest dostępny przy podłączeniu **debugowym. **

Mamy otwarte dwa porty: `ttyACM0` oraz `ttyACM1` 

Żeby połączyć się z płytką z hosta wywołaj komendę:

    picocom -b 115200 /dev/ttyACM0 

Aby wyjść z picocoma: `Ctrl+A, Ctrl+X`

### SSH

Po podłączeniu kabla ETH PC <-> płytka mamy dostęp do SSH.

Połącz się z płytką przez UART i sprawdź jej adres IP poleceniem:

    ifconfig

Z hosta:

    ssh root@<ADRES_IP>

**Q: Co jest potrzebne żeby z płytką można było się łączyć po SSH?**

ODP: stm32mp25-disco/st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260512103111.manifest

## Zadanie - system stats

Jakie zadanie spełniają `/proc` oraz `/sys`?

Napisz skrypt w shellu, który: 

Co 20 sekund odczyta następujące wartości:
- bieżącą temperaturę procesora
- Taktowanie procesora
- Uptime systemu 

I zapisze je do pliku w /var/log

## Zadanie - blink 
Napisz program (np. skrypt w shellu), który zamiga **zieloną** diodą LED na płytce (oznaczenie LD8).

Wykorzystaj poniższe informacje: 

GPIO for LEDs:
| LED Color and Label | GPIO |
| :--- | :--- |
| Green LD8 | PH5 |
| Red LD7 | PH4 |
| Orange LD9 | PH6 |
| Blue LED1 | PH7 |

Listowanie wszystkich GPIO: 

    gpioinfo

Ustawianie wartości:

    gpioset <PIN>=<WARTOŚC>

**Q:Jaki jest alternatywny sposób na miganie diodą?**
