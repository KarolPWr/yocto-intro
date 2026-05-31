Sciezka gdzie jest dtbo dla ST:

/workspace/layers/meta-st/meta-st-stm32mp/recipes-kernel/linux-devicetree/dtbo-stm32mp21x

skopiowac jak jest tam to zrobione

Tutaj też jet kawałek dokumentacji jak to jest zrobione:
meta-st/meta-st-stm32mp/conf/machine/stm32mp2.conf

Jeszcze informacje o DT od st:
https://wiki.st.com/stm32mpu/wiki/How_to_create_your_own_machine

a tutaj bootable devices:
https://wiki.st.com/stm32mpu/wiki/STM32_MPU_OpenSTLinux_release_note#Bootdevice_labels

Mój flow myślowy:
Szukam jak jest zrobione DTBO w ST, kopiuję to
Szukam jak wygląda główne DTS i podobne pliki, żeby zobaczyć jak są skonfigurowane LEDy

Kopiuję ten kawałek do mojego własnego DTBO ze zmianami

## Devicetree overlay

Utwórz katalogi:

    mkdir -p layers/meta-ifm/recipes-kernel/linux-devicetree/dtbo-green

Receptę oraz plik z overlayem:

    touch layers/meta-ifm/recipes-kernel/linux-devicetree/dtbo-green.bb
    touch layers/meta-ifm/recipes-kernel/linux-devicetree/dtbo-green/green-overlay.dts

Recepta:

    SUMMARY = "Custom Device Tree Overlay for My Project"
    SECTION = "bootloader"
    LICENSE = "MIT"
    LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

    inherit devicetree

    SRC_URI = "file://green-overlay.dts"

    S = "${WORKDIR}"

    COMPATIBLE_MACHINE = "(stm32mp25common)"

Overlay:

    /dts-v1/;
    /plugin/;

    #include <dt-bindings/gpio/gpio.h>
    #include <dt-bindings/leds/common.h>

    &{/gpio-leds} {
        led-green {
            function = LED_FUNCTION_HEARTBEAT;
            color = <LED_COLOR_ID_GREEN>;
            gpios = <&gpioh 5 GPIO_ACTIVE_HIGH>;
            linux,default-trigger = "heartbeat";
            default-state = "off";
        };
    };

Dodaj zmienne do local.conf:

    ST_DEVICE_OVERLAY_ADDONS:append = " dtbo-green"
    UBOOT_EXTLINUX_FDTOVERLAYS:append = " /devicetree/green-overlay.dtbo"

Propozycja zadania: zła ścieżka w UBOOT_EXTLINUX_FDTOVERLAYS:append = " /devicetree/green-overlay.dtbo" (było overlays )




## TODO - ręczna kompilacja
