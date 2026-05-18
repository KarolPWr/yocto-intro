# Optymalizacja rozmiaru

Jak sprawdzić co dokładnie jest w buildzie? 

## Zadanie - analiza manifestu

Znajdź plik kończący się na  .manifest w images/ w deploydir. 

Jakie packagesgroups mamy zawarte w obrazie? 

Jak sprzwdzić co znajduje się w danym packagegroup? 


## Zadanie - analiza buildhistory

Przejdź do 
workspace/build-openstlinuxweston-stm32mp25-disco/buildhistory

Jakiego typu pliki się tam znajdują? 

Sprawdź za pomocą buildhistory jakie paczki są dołączane w IMAGE_FEATURES do obrazu. 

Wylistuj 10 największych paczek w obrazie

Rozwiązanie:

    sort -n -r installed-package-sizes.txt | head -n 10




## Zadanie - Zmniejszenie obrazu 

Sprawdź ile obraz zajmuje obecnie:

a) w buildhistory - przez sprawdzenie zmiennej IMAGESIZE:

    IMAGESIZE = 757452

b) w deploy/images - przez zbadanie rozmiaru plików 


    ❯ ls -lh st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260514164254.ext4
    -rw-r--r-- 1 karol.przybylski karol.przybylski 968M maj 14 18:47 st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260514164254.ext4

    ❯ ls -lh st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260514164254.tar.xz
    -rw-r--r-- 1 karol.przybylski karol.przybylski 186M maj 14 18:47 st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260514164254.tar.xz

Dodaj linijki do local.conf:

    IMAGE_FEATURES:remove = "package-management"
    CORE_IMAGE_EXTRA_INSTALL:remove = "packagegroup-st-demo"
    IMAGE_FEATURES:remove = "packagegroup-framework-tools-audio"

Zmierz czas budowania dodając komendę time przez poleceniem:

    time bitbake st-image-weston

## Po buildzie

    ❯ ls -lh st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260518102745.tar.xz 
    -rw-r--r-- 1 karol.przybylski karol.przybylski 145M maj 18 12:33 st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260518102745.tar.xz

    deploy/images/stm32mp25-disco on ☁️  (eu-west-1) 
    ❯ ls -lh st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260518102745.ext4
    -rw-r--r-- 1 karol.przybylski karol.przybylski 872M maj 18 12:33 st-image-weston-openstlinux-weston-stm32mp25-disco.rootfs-20260518102745.ext4

## Test

Zaflashuj płytkę i sprawdź czy wszystko działa. (powinno działać)


