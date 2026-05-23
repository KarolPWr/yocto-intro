# Devtool

Devtool - umożliwia automatyzację podstawowych czynności przy developmencie. 

Między innymi - modyfikacja recept, tworzenie nowych, patchowanie, deploy itp. 

Dokumentacja: https://docs.yoctoproject.org/scarthgap/singleindex.html#document-ref-manual/devtool-reference

Patchowanie recept: https://docs.yoctoproject.org/scarthgap/singleindex.html#updating-a-recipe 

## Zadanie - patchowanie NUDOKU

CEL: Modyfikujemy kod źródłowy zewnętrznej paczki - NUDOKU. Musimy w związku z tym napisać patcha.

Chcemy żeby przy wywołaniu polecenia 

    $ nudoku -h 

Wyświetliło się nasze imię. 

Odpalamy devtool (w kontenerze)

    devtool modify nudoku

Powstanie w build dir katalog workspace/:

    /workdir/build-openstlinuxweston-stm32mp25-disco/workspace/sources/nudoku

W nim możemy wprowadzać zmiany na wypakowanych źródłach.

Wprowadzamy zmiany w dowolnym edytorze albo w terminalu. Następnie budujemy żeby zweryfikować:

    devtool build nudoku

Możemy od razu przetestować zmiany na targecie:

#TODO 10.42.0.243

    devtool deploy-target nudoku root@<target_ip>

Po sukcesie na targecie po wywołaniu

    nudoku -h

Powinniśmy zobaczyć zmieniony tekst helpa.

## Patchowanie w warstwie

Żeby devtool pozwolił nam stworzyć patch musimy zrobić commit na naszych zmianach.

    cd build-openstlinuxweston-stm32mp25-disco/workspace/sources/nudoku
    git add src/main.c
    git commit -m ">>>MESSAGE<<"

Żeby zakończyć pracę i wygenerować patch:

    devtool finish -f nudoku ../layers/meta-ifm

## Weryfikacja

Zwróć uwagę na zmiany w recepcie nudoku. Devtool samodzielnie:

- Dodał plik .patch w odpowiednim miejscu
- Dodał patcha do listy SRC_URI
