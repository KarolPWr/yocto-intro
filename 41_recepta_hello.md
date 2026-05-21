# Recepta hello world 

Dokumentacja pisania recept:

https://docs.yoctoproject.org/dev/dev-manual/new-recipe.html 

Przykłady: 

https://docs.yoctoproject.org/dev/dev-manual/new-recipe.html#examples 

Integrujemy receptę, która będzie budować aplikację hello world w C.

W warstwie meta-ifm w katalogu recipes-example stwórz katalog na nową receptę

    cd meta-ifm/recipes-example
    mkdir helloworld

Stwórz plik recepty - helloworld.bb

    cd helloworld
    touch helloworld.bb

Wklej zawartosć do pliku:

    SUMMARY = "Simple helloworld application"
    SECTION = "examples"
    LICENSE = "MIT"
    LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

    SRC_URI = "file://helloworld.c"

    S = "${WORKDIR}"

    do_compile() {
        ${CC} ${LDFLAGS} helloworld.c -o helloworld
    }

    do_install() {
        install -d ${D}${bindir}
        install -m 0755 helloworld ${D}${bindir}
    }

## Zadanie

W katalogu recipes-example/helloworld, stwórz katalog files. W files dodaj plik helloworld.c i wypełnij treścią:

    #include <stdio.h>

    int main() {

        printf("Hello World");

        return 0;
    }

Zbuduj program:

    bitbake helloworld

Wylistuj wszystkie taski dla danej recepty i zapoznaj się z ich opisem:

    bitbake -c listtasks st-image-weston

## Przydatne polecenia

    bitbake-getvar -r helloworld COMMON_LICENSE_DIR
    bitbake-getvar -r helloworld S

