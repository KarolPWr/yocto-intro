## Wstęp

TODO: Wytłumaczyć w prezentacji ogólnie bootowanie ale bez mega szczegółów. Szczegóły ogarnie się potem w zadaniu z bootflow.

Wejście do uboota:

Zresetuj devboarda z podłączonym UARTem, naciskaj dowolny klawisz aż pokaże się prompt u-boota:

    Hit any key to stop autoboot:  0 
    STM32MP>

Dostępne komendy:

    help

Zmienne środowiskowe:

    printenv

## Zadanie - zmienie

Wyświetl zmienne środowiskowe używając komendy

    printenv

Ustaw nową zmienną o nazwie FOO używając komendy

    setenv

Sprawdź czy została ustawiona. Możesz ją również wyświetlić przez echo

Zresetuj płytkę i sprawdź czy zmienna została zapisana. 

Powtórz poprzednie kroki, ale tym razem użyj 

    saveenv

Żeby zapisać zmienne. Po kolejnym resecie sprawdź czy zmienna się zapisała. Następnie przywróć środowisku wartości domyślne za pomocą komendy:

    env default -a
    saveenv

## Zadanie - rekonstrukcja bootflow

Wywołaj komendę

    printenv

Widząc że cały flow zaczyna się od komendy bootcmd, przeanalizuj w jakis sposób krok po kroku przebiega bootowanie w u-boocie. 



## extlinux.conf

Z logów wynika, że całym procesem zarządza plik - extlinux.conf 

Znajdź gdzie jest definiowany

Wygenerowane pliki są obecne na rootfs:

    root@stm32mp25-disco-e3-d2-a5:/boot# ls
    Image.gz          lost+found     splash_landscape.bmp    stm32mp257f-dk-ca35tdcid-ostl-m33-examples.dtb
    Image.gz-6.6.116  mmc0_extlinux  splash_portrait.bmp     stm32mp257f-dk-ca35tdcid-ostl.dtb
    boot.scr.uimg     mmc1_extlinux  st-image-resize-initrd  stm32mp257f-dk.dtb

## Zadanie - modyfikacja extlinux.conf

Dodanie opcji w menu, po wyborze następuje reset

## Zadanie - modyfikacja u-boota 

Dodanie nowej komendy do wykorzystania 