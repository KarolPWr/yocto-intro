# Zadanie: Personalizacja ekranu powitalnego (MOTD) przez bbappend

### Treść zadania
Zmień domyślny komunikatu powitalnego, który wyświetla się w terminalu po zalogowaniu na devboarda (plik `/etc/motd`). 

Zmień domyślny tekst na spersonalizowany komunikat dla firmy:
> **Welcome to IFM Linux System v1.0**

---

### Instrukcja krok po kroku

**Zlokalizuj przepis bazowy:**
   Odnajdź w głównej warstwie `meta` receptę odpowiedzialną za podstawowe pliki systemowe: `base-files_%.bb` 


    meta/recipes-core/base-files/


**Utwórz strukturę we własnej warstwie:**
   Wewnątrz wcześniej przygotowanej warstwy `meta-ifm` odtwórz odpowiednią strukturę katalogów i utwórz plik rozszerzenia `.bbappend`:
   
    meta-ifm/recipes-core/base-files/base-files_%.bbappend


Wpisz do utworzonego pliku .bbappend poniższą zmienną, aby Yocto szukało plików źródłowych najpierw w Twojej warstwie:

    FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

Dodaj nowy plik motd:

Obok pliku .bbappend utwórz katalog o nazwie base-files, a w nim zwykły plik tekstowy o nazwie motd. Wpisz do niego nową treść.

Struktura katalogów powinna wyglądać następująco:

    meta-ifm/recipes-core/base-files/
    ├── base-files_%.bbappend
    └── base-files/
        └── motd

Kompilacja i weryfikacja:

Przebuduj obraz systemu

Sflashuj płytkę STM32MP257-DK i uruchom system.

Zweryfikuj, czy wita Cię spersonalizowany komunikat.