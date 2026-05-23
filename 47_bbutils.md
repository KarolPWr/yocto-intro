# bbappend

Dokumentacja: 

https://docs.yoctoproject.org/bitbake/bitbake-user-manual/bitbake-user-manual-library-functions.html#module-bb.utils 


## Zadanie 1 - modyfikacja CFLAGS

CFLAGS += "${@bb.utils.contains('IMAGE_FEATURES', 'debug-tweaks', ' -Werror', '', d)}"

Po poprawnym wykonaniu zadania (kompilacja zrobi FAIL), możesz zmienić (np. odwrócić warunek) lub usunąć tę linijkę.


## Zadanie 2 - install_append

Do recepty nudoku dopisz następujący fragment kodu:

    do_install_append() {
        if [ "${INSTALL_EXTRA_CONFIG}" = "yes" ]; then
            install -d ${D}${sysconfdir}/nudoku2
            install -m 0644 ${S}/README.md ${D}${sysconfdir}/nudoku2/README.md
        fi
    }

Powyżej niego dopisz brakujący kawałek logiki:

Ustaw flagę INSTALL_EXTRA_CONFIG na "yes" jeżeli w local.conf zmienna EXTRA_CONFIG jest ustawiona na 1. 

Skorzystaj z @bb.utils.contains

Rozwiązanie:

    INSTALL_EXTRA_CONFIG = "${@bb.utils.contains('EXTRA_CONFIG', '1', 'yes', 'no', d)}"
