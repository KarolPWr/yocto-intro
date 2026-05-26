# Analiza bootflow

Zrzucamy całe środowisko:

    printenv

Co wiemy - zaczyna się od bootcmd

    bootcmd=run bootcmd_stm32mp

bootcmd_stm32_mp2:

    bootcmd_stm32mp=echo "Boot over ${boot_device}${boot_instance}!";if test ${boot_device} = serial || test ${boot_device} = usb;then stm32prog ${boot_device} ${boot_instance}; else run env_check;if test ${boot_device} = mmc;then env set boot_targets "mmc${boot_instance}"; fi;if test ${boot_device} = nand || test ${boot_device} = spi-nand ;then env set boot_targets ubifs0 mmc0; fi;if test ${boot_device} = nor;then env set boot_targets mmc0; fi;run distro_bootcmd;fi;

distro_bootcmd:

    distro_bootcmd=for target in ${boot_targets}; do run bootcmd_${target}; done

boot_targets: 

    boot_targets=mmc1 ubifs0 mmc0 mmc2 usb0 pxe

bootcmd_mmc1:

    run bootcmd_mmc1

bootcmd_mmc1:

    devnum=1; run mmc_boot

mmc_boot:

    if mmc dev 1; then devtype=mmc; run scan_dev_for_boot_part; fi

Szukamy partycji rozruchowej

    run scan_dev_for_boot

Na koniec:

    run scan_dev_for_extlinux

Szukamy pliku extlinux.conf gdzie są zapisane zmienne - devicetree itp. 

    scan_dev_for_extlinux=if test -e ${devtype} ${devnum}:${distro_bootpart} ${prefix}${boot_syslinux_conf}; then echo Found ${prefix}${boot_syslinux_conf}; run boot_extlinux; echo EXTLINUX FAILED: continuing...; fi

boot_extlinux:

    sysboot mmc 1:${distro_bootpart} any 0x90100000 /extlinux/extlinux.conf

Co robi komenda sysboot? Z dokumentacji uboota:

    sysboot

    Load and boot an extlinux.conf file from a local filesystem. Paths in the extlinux.conf file (kernel, initrd, FDT and overlays) will be interpreted within that filesystem.

Źródło: https://docs.u-boot-project.org/en/latest/usage/pxe.html#commands
