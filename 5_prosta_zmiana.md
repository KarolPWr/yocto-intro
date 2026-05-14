Prosta zmiana w recepcie, żeby zauważyć co się zmienia. 
weston.ini

## Prosta zmiana w systemie

Zmodyfikuj plik:

    layers/meta-st/meta-st-openstlinux/recipes-graphics/wayland/weston-init/weston.ini

Zmień parametr

    panel-color=0xffffd200

na:

    panel-color=0xff00ff00 

lub na dowolny inny kolor (ale w postaci hex)

Przebuduj obraz:

    bitbake st-image-weston

Zaflashuj ponownie płytkę

Jakie zmiany zaszły w systemie?

**Q: Czy jest to efektywny sposób na wprowadzania zmian?**

