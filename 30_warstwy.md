# Warstwy

Lista warstw:

https://layers.openembedded.org/layerindex/branch/master/layers/

To nie wszystkie, ale większość. 

Sprawdź jakie warstwy są obecnie skonfigurowane w projekcie:

    bitbake-layers show-layers

## Integracja zewnętrznej warstwy

Przejdź do katalogu layers/

    cd layers

Pobierz warstwę meta-security

    git clone https://git.yoctoproject.org/meta-security 

### Dodanie programu

Dodaj program z warstwy do buildu przez modyfikację local.conf:

    vim local.conf
    DISTRO_FEATURES:append = " apparmor"

Wybuduj:

    bitbake st-image-weston


    ERROR: Nothing RPROVIDES 'apparmor' (but /workdir/layers/meta-st/meta-st-openstlinux/recipes-st/images/st-image-weston.bb RDEPENDS on or otherwise requires it)
    apparmor was skipped: missing required distro feature 'apparmor' (not in DISTRO_FEATURES)


**Q: Jak naprawić ten błąd?**

W kontenerze - dodaj warstwę do konfiguracji

    bitbake-layers add-layer ../layers/meta-security/ 

    ERROR: Layer security is not compatible with the core layer which only supports these series: scarthgap (layer is compatible with wrynose)
    ERROR: Parse failure with the specified layer added, exiting.

**Q: Jak naprawić ten błąd?**

Przejdź do meta-security i zrób checkout:

    git checkout -b training_scarthgap b13f1705d723650de61277670c8a76aadea4cfdd

Potwierdź że warstwa jest dodana:

    bitbake-layers show-layers

Dodaj program z warstwy do buildu przez modyfikację local.conf:

    vim local.conf
    IMAGE_INSTALL:append = " apparmor"

Wybuduj:

    bitbake st-image-weston



## Debugowanie

bitbake -e

bitbake -e <image> | grep ^IMAGE_ROOTFS

bitbake-getvar

## Tworzenie własnych warstw

Stwórz nową warstwę za pomocą bitbake-layers:

    bitbake-layers create-layer -a meta-ifm

Potwierdź że została poprawnie dodana:

    bitbake-layers show-layers

**Q: Jak wygląda warstwa? Gdzie jest skonfigurowana?**

Przeanalizuj kod przykładu a następnie go zbuduj. 

Zbuduj program przykładowy:

    bitbake example



