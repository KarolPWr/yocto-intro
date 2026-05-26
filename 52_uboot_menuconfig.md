# zmiana konfiguracji u-boota

## Jako patch

Zaczynamy pracę z devtoolem:

    devtool modify u-boot-stm32mp

Przechodzimy do sources

Patrzymy czy istnieje plik .config

    cat .config

Wywołujemy menu koncifugracyjne

    make menuconfig

Zaznaczamy że chcemy dodać WDT

    Command line -> 

Zapisujemy jako defconfig

    make savedconfig

Przenosimy do configa oryginalnego

    cp defconfig configs/stm32mp25_defconfig


Trzeba wyczyścić konfigurację:

    make mrproper

Kończymy:

    devtool finish u-boot-stm32mp ../layers/meta-ifm

## Jako confguration fragment 



Przechodzimy do źródeł:

    cd workspace

Wykonujemy domyślny defconfig:

    make stm32mp25_defconfig

Wprowadzamy zmiany

    make menuconfig 

Zmieniamy prompt systemowy na IFM32>

    Command line interface ---> Shell prompt

Zapisujemy jako defconfig

    make savedefconfig

Patrzymy na diff:

    diff -u  configs/stm32mp25_defconfig defconfig

Za pomocą sprytnej komendy czyścimy diffa i generujemy configuration fragment:

    diff -u configs/stm32mp25_defconfig defconfig | grep '^\+' | grep -v '+++' | sed 's/^+//' > my_settings.cfg

Czyścimy konfigurację:

    make mrproper

Przenosimy my_settings.cfg do naszej warstwy do bbappenda z ubootem

    layers/meta-ifm/recipes-bsp/u-boot/u-boot-stm32mp/my_settings.cfg

Budujemy obraz

    bitbake ifm-image-weston

Wgrywamy i testujemy. Powinien nas przywitać taki prompt w uboocie:

    IFM32>

