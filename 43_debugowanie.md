# Debugowanie i triki w bitbake 

Czyszczenie

    bitbake -c cleanall

Konkretna komenda/task

    bitbake -c

Dokumentacja

    bitbake -h

Zrzut wszystkich zmiennych, bardzo przydatne do debugowania

    bitbake -e

Komendy można również łączyć z innymi, np z poleceniem grep

Budowanie „ile się da”:

    bitbake -k lub bitbake --continue

## Zadanie 1 - literówka

Wprowadź literówkę do recepty - zamień linijkę 

    SRC_URI = "file://helloworld.c"

na

    SRC_URI = "file://helloword.c"

Za pomocą polecenia

    cd workspace/layers
    fd -HI "helloworld"

Znajdź wszystkie pliki. Napraw błąd.

## Zadanie 2 - błąd kompilacji 

Podmień treść programu helloworld.c na taką:

    #include <stdio.h>

    int main() {

        printf("Hello World"

        return 0;
    }

Zbuduj receptę:

    bitbake helloworld

Z pomocą dowolnego programu (np. klogg) wyświetl zawartość pliku

    do_compile.log 

Plik znajduje się w WORKDIR dla tej recepty. Możesz znaleźc tą ścieżkę np. używajac bitbake-getvar

Nie musimy za każdym razem odpalać buildu na nowo. 

Odpal kompilację dla helloworld ręcznie

    ./run.do_compile

Jeżeli otrzymasz podobny błąd:

    ./run.do_compile: 143: cd: can't cd to /workdir/build-openstlinuxweston-stm32mp25-disco/tmp-glibc/work/cortexa35-ostl-linux/helloworld/1.0
    WARNING: exit code 2 from a shell command.

To znaczy że polecenie wykonałeś poza kontenerem.

Napraw błąd "na szybko" modyfikując helloworld.c w WORKDIR i odpal ponownie kompilację ręcznie. 

Nie będzie dodatkowych logów, ale w WORKDIR powinien pojawić się plik wykonywalny helloworld (wynik poprawnej kompilacji)

Potem zrób fixa w głównym pliku w katalogu z receptą.

## Zadanie 3 - zmienne

Znajdź wartość zmiennych S, B, D oraz bindir za pomocą poznanych narzędzi.



