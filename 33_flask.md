# Integracja serwera flask

do local.conf

    IMAGE_INSTALL:append = " python3-flask"

Budujemy ponownie:

    bitbake st-image-weston


## Zadanie - check
Przed wrzuceniem na sprzęt przeanalizuj rootfs, czy wszystko zostało poprawnie wrzucone. 

Wrzucamy na HW, testujemy. W terminalu na targecie:

    python3

    >>> import flask

Jak nie ma błędu to znaczy że jest OK.

Piszemy aplikację (na targecie):

    vi hello.py

Kod:

    from flask import Flask
    app = Flask(__name__)

    @app.route('/')
    def hello_world():
        return 'Hello, from Flask on Yocto!'

    if __name__ == '__main__':
        app.run(host='0.0.0.0', port=5000)
    
odpalamy z palca:

    python3 hello.py

Podłączamy kabel ETH (networking już mamy)

Ewentualnie sharujemy połączenie z komputera. 

Za pomocą polecenia 

    ifconfig 

sprawdzamy czy jest adres IP, poczekać z 20 sekund 

W przeglądarce na komputerze sprawdzamy GUI:

    http://<stm32mp2-ip-address>:5000     