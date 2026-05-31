# Kernel hello world

Stwórz receptę:

    layers/meta-ifm/recipes-kernel/hello-kernel/hello-kernel_1.0.bb

Kod:

    SUMMARY = "Simple Hello World Kernel Module"
    LICENSE = "GPL-2.0-only"
    LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

    inherit module

    DEPENDS += "openssl-native"

    SRC_URI = "file://hello_kernel.c \
            file://Makefile"

    S = "${WORKDIR}"

Stwórz plik z kodem źródłowym:

    layers/meta-ifm/recipes-kernel/hello-kernel/files/hello_kernel.c

Kod:

    #include <linux/module.h>
    #include <linux/kernel.h>

    static int __init hello_init(void) {
        pr_info("Hello World: Kernel module loaded!\n");
        return 0;
    }

    static void __exit hello_exit(void) {
        pr_info("Hello World: Kernel module unloaded!\n");
    }

    module_init(hello_init);
    module_exit(hello_exit);

    MODULE_LICENSE("GPL");
    MODULE_AUTHOR("Trainer");
    MODULE_DESCRIPTION("A simple Hello World module");

Stwórz plik Makefile w files/ 

    obj-m := hello_kernel.o

    SRC := $(shell pwd)

    all:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules

    modules_install:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) modules_install

    clean:
        $(MAKE) -C $(KERNEL_SRC) M=$(SRC) clean

**Dodaj hello-kernel do local.conf**

# Upload i testowanie

Nie musimy za każdym razem przebudowywać obrazu. Wystarczy przerzucić plik .ko na target za pomocą SCP i załadować ręcznie. 

Wyszukiwanie:

    fd -HI hello_kernel.ko

Kopiowanie: 

    scp tmp-glibc/sysroots-components/stm32mp25_disco/hello-kernel/usr/lib/modules/6.6.116/updates/hello_kernel.ko root@<IP>:/tmp

Ładowanie ręczne:

    insmod /tmp/hello_kernel.ko

Sprawdzamy logi z bufora kernela:

    dmesg | tail

Sprawdzenie czy moduł jest załądowany:

    lsmod | grep hello

Usuwanie modułu:

    rmmod hello_kernel



