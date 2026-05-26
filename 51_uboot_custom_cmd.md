# Custom cmd

devtool modify uboot

    devtool modify u-boot-stm32mp

wprowadzamy zmiany - nowa komenda, w pliku ifm_cmd.c

    build-openstlinuxweston-stm32mp25-disco/workspace/sources/u-boot-stm32mp/cmd/ifm_cmd.c

Kod:

    #include <common.h>
    #include <command.h>

    static int do_hello(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
    {
            printf("Hello from my new U-Boot command!\n");
            return 0;
    }

        U_BOOT_CMD(
            hello,      /* Command name */
            1,          /* Max arguments */
            1,          /* Repeatable */
            do_hello,   /* Implementation function */
            "print hello message", /* Short help */
            ""          /* Long help */
        );

Dodajemy do Makefile żeby się budowało:

    obj-y += ifm_cmd.o

Budujemy:

    devtool build u-boot-stm32mp

Jak się zbuduje bez błędów to przed finishem jeszcze zbudujemy obraz

    devtool build-image ifm-image-weston

Wgrywamy i patrzymy czy działa

## Programowanie tylko u-boota

Przełączamy w tryb DFU, flashujemy nowy obraz

Po resecie i zalogowaniu się do U-boota taki powienien być efekt:

    STM32MP> hello
    Hello from my new U-Boot command!

## Zadanie dodatkowe 

Komenda hello powinna jeszcze robić TOGGLE na niebieskiej diodzie LED.

Ledy można podejrzeć w u-boocie:

    STM32MP> led list
    led-blue        on

Rozwiązanie (vibe-coded):

    #include <common.h>
    #include <command.h>
    #include <led.h>
    #include <dm.h>

    static int do_hello(struct cmd_tbl *cmdtp, int flag, int argc, char *const argv[])
    {
        struct udevice *dev;
        int ret;

        ret = led_get_by_label("led-blue", &dev);
        if (ret) {
            printf("Error: Could not find led-blue (error %d)\n", ret);
            return CMD_RET_FAILURE;
        }

        ret = led_set_state(dev, LEDST_TOGGLE);
        if (ret) {
            printf("Error: Could not toggle led-blue (error %d)\n", ret);
            return CMD_RET_FAILURE;
        }

        printf("Blue LED toggled successfully.\n");
        return CMD_RET_SUCCESS;
    }

    U_BOOT_CMD(
        hello,      /* Command name */
        1,          /* Max arguments */
        1,          /* Repeatable */
        do_hello,   /* Implementation function */
        "toggle blue LED", /* Short help */
        ""          /* Long help */
    );
