# bbclass 

Przykłady bbclass:

    fd -HI ".*.bbclass"

Recepty używajace klasy cmake:

    rg --no-ignore "inherit.*cmake"

Wewnątrz swojej warstwy `meta-ifm` utwórz katalog `classes`:
   
```bash
   mkdir -p meta-ifm/classes
```

Napisz klasę build-info.bbclass:

W katalogu meta-ifm/classes/ utwórz plik build-info.bbclass o następującej treści:

    python do_generate_buildinfo () {
        import os
        import datetime
        import subprocess

        pn = d.getVar('PN')
        buildhost = d.getVar('BUILDHOST')
        target_arch = d.getVar('TARGET_ARCH')
        workdir = d.getVar('WORKDIR')

        bb.warn(f"Build Info: Hello {pn} (arch: {target_arch})")
        bb.warn(f"Workdir: {workdir}")
    }

    addtask do_generate_buildinfo after do_compile before do_install



Oraz funkcja modyfikująca do_install:

    do_compile:append() {
        bbwarn "Class do_compile:append: Hello world from ${USER}"
    }

## Zadanie 1 - test

dodaj do recepty nudoku 

    inherit build-info

Zbuduj nudoku i zobacz czy klasa działa.

    bitbake nudoku

## Zadanie 2 - modyfikacja

Dopisz do klasy wyświetlanie zmiennych - PN, PV oraz S.


