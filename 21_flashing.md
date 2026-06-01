# Instrukcja flashowania

## Tryby zasilania płytki

Tryby:
- Zwykły - podłączone zasilanie do portu USB PWR
- Debugowy - podłączony kabel USB-C: PC <-> USB PWR, mamy połączenie z UART
- DFU - zasilanie do portu USB PWR,  kabel USB-C PC <-> USB DRD


## Wgranie na kartę SD (poza kontenerem!)

Sprawdż pod jaki DEVICE podłączy się karta pamięci

    dmesg -w
    # Włóż kartę pamięci do slotu
    Na podstawie outputu z dmesg podmień <DEVICE> w komendzie (np. na sda)

    Stwórz obraz na kartę SD za pomocą skryptu: 
    cd build-openstlinuxweston-stm32mp25-disco/tmp-glibc/deploy/images/stm32mp25-disco

    ./scripts/create_sdcard_from_flashlayout.sh flashlayout_st-image-weston/optee/FlashLayout_sdcard_stm32mp257f-dk-optee.tsv

Wypal obraz na karcie SD:

    sudo dd if='flashlayout_st-image-weston/optee/../../FlashLayout_sdcard_stm32mp257f-dk-optee.raw' of=<DEVICE> bs=8M conv=fdatasync status=progress && sync

Przełącz na płytce boot switche w pozycję "boot from SD card" (1000)

Mapping boot switchy: https://wiki.st.com/stm32mpu/wiki/STM32MP257x-DKx_-_hardware_description#Boot_switches

Wsadź kartę SD do slotu

Podłącz zasilanie

## Wgranie do pamięci EMMC 

Musimy zmodyfikować obraz i dodać budowanie plików dla EMMC.

Dodaj na koniec pliku local.conf następujące linie:

    BOOTDEVICE_LABELS += "emmc"
    STM32MP_DT_FILES_EMMC += "stm32mp257f-dk"

Przebuduj obraz

    bitbake st-image-weston

Do zapisania pamięci EMMC potrzebny będzie program (instrukcja instalacji jest w PDF z przygotowaniem)

    STM32_Programmer_CLI

Przejdź do:

    build-openstlinuxweston-stm32mp25-disco/tmp-glibc/deploy/images/stm32mp25-disco

Przełącz płytkę w tryb DFU: 
- podłącz port USB DRD kablem USB-C do komputera
- podłącz zasilacz do portu USB PWR

Sprawdź czy płytka jest w trybie DFU:

    STM32_Programmer_CLI -l

Tak wygląda oczekiwany output:

    =====  DFU Interface   =====

    Total number of available STM32 device in DFU mode: 1

Wgranie do EMMC za pomocą komendy:

    STM32_Programmer_CLI -c port=usb1 -w flashlayout_st-image-weston/optee/FlashLayout_emmc_stm32mp257f-dk-optee.tsv

Jeśli nie zadziała USB1 - zobacz w outpucie z programmera, pod które USB podłączyła się płytka.

Gdy komenda zakończy wgrywanie: 

- odłącz kabel zasilania, 
- przełącz boot switche w pozycję EMMC boot (0100)
- podłącz zasilanie (najlepiej w trybie debugowym)
- sprawdź na monitorze czy wstało środowisko graficzne