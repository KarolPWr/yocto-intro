## Ściągamy warstwy

    cd workspace
    repo init -u https://github.com/STMicroelectronics/oe-manifest.git -b refs/tags/openstlinux-6.6-yocto-scarthgap-mpu-v26.02.18
    repo sync

**Q: Co pojawiło się w workspace?**

Otwieramy kontener w workspace:

    ~/start_yocto_env.sh

Konfigurujemy build env:

    DISTRO=openstlinux-weston MACHINE=stm32mp25-disco source layers/meta-st/scripts/envsetup.sh

Kopiujemy downloads i sstate-cache:

#TODO copy DL and SSTATE

git config --global user.email "you@example.com"
git config --global user.name "Your Name"

Budujemy obraz:

    bitbake st-image-weston

**Q: Gdzie znajduje się obraz?**