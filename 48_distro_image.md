# Distro vs Image

CEL: Przeniesienie ustawień z local.conf do własnego obrazu i dystrybucji. 

DISTRO - definiuje "OS Policy" - globalne ustawienia, które aplikują się do każdej recepty w projekcie. Zdefiniowane w pliku .conf

IMAGE - definiuje "Content" - czyli konkretny zestaw paczek i ficzerów na rootfs. Zdefiniowane w recepcie, czyli pliku .bb


## Zadanie 1 - Distro

Utwórz plik

    layers/meta-ifm/conf/distro/ifm-distro.conf


Treść:

    # Inherit from the base OpenSTLinux distribution
    require conf/distro/openstlinux-weston.conf

    DISTRO = "ifm-distro"
    DISTRO_NAME = "IFM OpenSTLinux Distro"

    # Move Hardware/Boot policies from local.conf
    BOOTDEVICE_LABELS += "emmc"
    STM32MP_DT_FILES_EMMC += "stm32mp257f-dk"

    # Move Global OS features from local.conf
    DISTRO_FEATURES:append = " apparmor"

## Zadanie 2 - Image

Utwórz plik:

    layers/meta-ifm/recipes-st/images/ifm-image-weston.bb

Treść:

    SUMMARY = "IFM custom image based on st-image-weston"
    LICENSE = "MIT"

    # Require the base image you want to extend
    require recipes-st/images/st-image-weston.bb

    # Move image feature removals from local.conf
    IMAGE_FEATURES:remove = "package-management"
    IMAGE_FEATURES:remove = "packagegroup-framework-tools-audio"

    # Move package removals from local.conf
    CORE_IMAGE_EXTRA_INSTALL:remove = "packagegroup-st-demo"

    # Move additional package installations from local.conf
    IMAGE_INSTALL:append = " python3-flask nudoku"

## Wprowadzamy zmiany

Podmień zmienną DISTRO na inną wartość w local.conf:

    DISTRO = "ifm-distro"

Podsumowanie zmian:

| Configuration Type | Recommended Location | Purpose |
| :--- | :--- | :--- |
| **Global OS Policy** | Distro (`.conf`) | Security (AppArmor), global classes (`INHERIT`). |
| **Hardware Policy** | Distro (`.conf`) | Boot devices, Device Tree selections. |
| **Image Content** | Image (`.bb`) | Package lists (`IMAGE_INSTALL`), removals. |
| **Local Environment** | `local.conf` | Path settings (`DL_DIR`), user-specific tweaks. |


# UWAGA!

Z czym będzie problem:

Skrypt z którego korzystamy do setupu środowiska szuka konfiguracji distro tylko w meta-st:

    layers/meta-st/scripts/envsetup.sh

    _META_LAYER_ROOT=layers/meta-st

Ponieważ definicja distro jest w naszym layerze to nie zostanie znaleziona. Skrypt wykryje błąd i nie zainicjalizuje środowiska. 

Musimy przekazać więcej zmiennych środowiskowych do polecenia:

export DISTRO=ifm-distro
export MACHINE=stm32mp25-disco
export META_LAYER_ROOT=layers
export TEMPLATECONF=$PWD/layers/meta-st/meta-st-openstlinux/conf/templates/default

BUILD_DIR=build-openstlinuxweston-stm32mp25-disco

Od teraz envsetup wykonujemy tak:

    DISTRO=ifm-distro MACHINE=stm32mp25-disco BUILD_DIR=build-openstlinuxweston-stm32mp25-disco META_LAYER_ROOT=layers TEMPLATECONF=$PWD/layers/meta-st/meta-st-openstlinux/conf/templates/default source layers/meta-st/scripts/envsetup.sh


Budowanie:

    bitbake ifm-image-weston

ORAZ nowa metoda wgrywania (inna nazwa obrazu!):

    STM32_Programmer_CLI -c port=usb1 -w flashlayout_ifm-image-weston/optee/FlashLayout_emmc_stm32mp257f-dk-optee.tsv

# Podsumowanie

Start środowiska:

    DISTRO=ifm-distro MACHINE=stm32mp25-disco BUILD_DIR=build-openstlinuxweston-stm32mp25-disco META_LAYER_ROOT=layers TEMPLATECONF=$PWD/layers/meta-st/meta-st-openstlinux/conf/templates/default source layers/meta-st/scripts/envsetup.sh


Budowanie:

    bitbake ifm-image-weston


Wgrywanie:

    STM32_Programmer_CLI -c port=usb1 -w flashlayout_ifm-image-weston/optee/FlashLayout_emmc_stm32mp257f-dk-optee.tsv