## Integracja zewnętrznej recepty

Zapoznaj się z algorytmem tworzenia recept

Źródła nudoku:

https://github.com/jubalh/nudoku 

## Zadanie - integracja recepty

CEL: Napisz receptę dla programu nudoku. Przetestuj czy działa na płytce.

Stwórz katalog nudoku w meta-ifm/recipes-example

Zacznij od recipetool:

w kontenerze:

    recipetool create -o ../layers/meta-ifm/recipes-example/nudoku/ https://github.com/jubalh/nudoku/archive/refs/tags/5.0.0.tar.gz

Sprawdź zawartość stworzonej recepty:

    layers/meta-ifm/recipes-example/nudoku/nudoku_5.0.0.bb

Zbuduj program:

    bitbake nudoku

Sprawdź zawartość WORKDIR. Czy wszystko wygląda tak jak powinno?

## RM_WORK

W local.conf znajduje się 

    INHERIT += "rm_work"

co powoduje że nie mamy podglądu do wszystki plików pośrednich. Jeśli build się uda to wszystko co niepotrzebne jest usuwane. 

Mozemy to obejść przez wywoływanie tasku do_install:

    bitbake -c cleansstate nudoku
    bitbake -c install nudoku




## Zadanie - dodaj flagi do kompilacji

Dodaj flagi kompilacji -Wall -Wextra do kompilacji recepty.

Zweryfikuj w logach czy zostały wzięte pod uwagę. 

Podpowiedź - użyj zmiennej CFLAGS 

TODO: Dać rozwiazanie? 

    CFLAGS:append = "-Wall -Wextra"

## Zadanie - zmiana katalogu 

Sprawdź wartość zmiennej

    datadir

Zainstaluj nudoku w tym katalogu.

Na koniec przetestuj czy działa na HW. Pamietaj o dodaniu nudoku do IMAGE_INSTALL w local.conf

Przed wgraniem sprawdź w ROOTFS czy jest tam plik z aplikacją i czy jest w odpowiednim miejscu.