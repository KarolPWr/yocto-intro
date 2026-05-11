# Praca z kontenerem 

## Sprawdzenie czy docker działa
    docker --version

Przykładowy output:

    docker --version

    Docker version 24.0.7, build 24.0.7-0ubuntu2~22.04.1

## Odpalanie kontenera

Korzystamy z kontenera crops/poky:

    mkdir workspace && cd workspace
    docker run --rm -e HISTFILE=/workdir/.bash_history -it -v <SCIEZKA DO WORKSPACE>:/workdir crops/poky:ubuntu-22.04 --workdir=/workdir

Po chwili powinniśmy zobaczyć prompt systemowy:

    pokyuser@40e16a3f8d21:/workdir$

Komenda jest dość długa. Możesz utworzyć skrypt w katalogu domowym, w którym będzie polecenie:

    cat << 'EOF' > ~/start_yocto_env.sh
    #!/bin/bash
    docker run --rm -e HISTFILE=/workdir/.bash_history -it -v /media/karol.przybylski/67b58e3e-322b-495d-b13d-838d81f246152/live_workspace:/workdir crops/poky:ubuntu-22.04 --workdir=/workdir
    EOF

    chmod +x ~/start_yocto_env.sh

Kontener jest gotowy do pracy z yocto.

W kontenerze musimy odpalać polecenia związane z bitbake, oe-pkg-util itp. 
Modyfikacje plików, szukanie itp. można robić POZA kontenerem. 

