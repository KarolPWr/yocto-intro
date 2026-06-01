# Praca z kontenerem 

Instrukcja instalacji dockera (Kroki z “Install using the apt repository”):

https://docs.docker.com/engine/install/ubuntu/ 


**Oraz** https://docs.docker.com/engine/install/linux-postinstall 

Wszystko działa poprawnie jeśli polecenie (bez sudo)

    docker run hello-world

Zwraca:

    Hello from Docker!
    This message shows that your installation appears to be working correctly.


## Sprawdzenie czy docker działa
    docker --version

Przykładowy output:

    docker --version

    Docker version 24.0.7, build 24.0.7-0ubuntu2~22.04.1

## Odpalanie kontenera

Tworzymy miejsce, gdzie będziemy pracować z naszym buildem.

Korzystamy z kontenera crops/poky:

    mkdir workspace && cd workspace
    docker run --rm --net=host -e HISTFILE=/workdir/.bash_history -it -v <SCIEZKA DO WORKSPACE>:/workdir crops/poky:ubuntu-22.04 --workdir=/workdir

Po chwili powinniśmy zobaczyć prompt systemowy:

    pokyuser@40e16a3f8d21:/workdir$

Komenda jest dość długa. Możesz utworzyć skrypt w katalogu domowym, za pomocą dwóch poniższych poleceń:

**Podmień ścieżkę na prawidłową**

```bash 
cat << 'EOF' > ~/start_yocto_env.sh
#!/bin/bash
docker run --rm --net=host -e HISTFILE=/workdir/.bash_history -it -v <SCIEZKA DO WORKSPACE>:/workdir crops/poky:ubuntu-22.04 --workdir=/workdir
EOF

chmod +x ~/start_yocto_env.sh
```

Kontener jest gotowy do pracy z yocto.

    ~/start_yocto_env.sh


W kontenerze musimy odpalać polecenia związane z bitbake, oe-pkg-util itp. 

Modyfikacje plików, szukanie itp. można robić **poza kontenerem.** 

