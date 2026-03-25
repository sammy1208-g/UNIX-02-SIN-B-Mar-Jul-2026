uname -a # Da la información completa del sistema operativo  / respuesta: Linux codespaces-dd4d4b 6.8.0-1044-azure #50~22.04.1-Ubuntu SMP Wed Dec  3 15:13:22 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
which gpg # Nos dice en qué ruta está instalado GPG / respuesta: /usr/bin/gpg
gpg --version # # Muestra la versión de GPG instalada / respuesta : gpg (GnuPG) 2.4.4 ....
gpg --full-generate-key # generate key
gpg --list-keys # List keys
gpg --armor --export chamorrosamy525@gmail.com > mi_llave publica.asc # exporta la clave pública y la guarda en un archivo .asc
ls mi_llave_publica.asc # verifica que el archivo se haya creado
gpg --armor --export # exporta clave pública
gpg --list-secret-keys --keyid-format=long # para listar las llaves privadas
gpg --armor --export-secret-keys  # para especificar el hash de las llaves
# gpg --pinentry-mode loopback --armor --export-secret-keys C942833FAF2766C1  / EN MICASO NO ME VALIO  EL ANTERIOR COMANDO Y APLIQUE ESTE COMANDO PARA QUE FUNIONARA Y ME SALIERA MI LLAVE PRIVADA.
# El comando permite exportar la clave privada en formato ASCII, utilizando el modo loopback para ingresar la contraseña directamente en la terminal, lo cual es útil en entornos sin interfaz gráfica.
gpg --import JenniMICOMPA_llave_publica.asc  #  compartir llave
gpg --list-keys # listar llaves de mi compa
$ echo "este mensaje es secreto" > doc_no_cifrado.txt # guardar un mensaje para nuestro compañero, en este caso "este mensaje es secreto"
ls # mostar nombres de archivos y carpetas.
cat doc_no_cifrado.txt # mostrar el contenido de un archivo de texto directamente en la terminal.
gpg --output doc_cifrado.txt --encrypt --recipient condorjeniffer0@gmail.com doc_no_cifrado.txt # usamos el hash o correo de la clave publica de nuestro compa para cifrar el documento
gpg --decrypt JMICOMPA_doc_cifrado.txt # decifrado el documento enviado por nuestro compa
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt
ls # ver archivos
cat doc_no_cifrado_firmado.txt # permite ver contenido del archivo (incluyendo la firma)
