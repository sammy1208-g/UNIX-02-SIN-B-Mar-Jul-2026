uname -a
which gpg
gpg --version
gpg --full-generate-key  # generar clave
gpg --list-keys # listar llaves 
gpg --armor --export chamorrosamy525@gmail.com > mi_llave publica.asc
ls mi_llave_publica.asc
gpg --armor --export
gpg --list-secret-keys --keyid-format=long #para listar las llaves privadas
# 23909E79DC4B0DF0
gpg --armor --export-secret-keys # para especificar el hash de las llaves
gpg --import JENNIMICOMPA_llave_publica.asc # compartir llave
gpg --list-keys # listar llaves de mi compa
$ echo"este mensaje es secreto" > doc_no_cifrado.txt # guardar un mensaje para nuestro compa
ls # mostar nombres de archivos y carpetas.
cat doc_no_cifrado.txt # mostrar el contenido de un archivo de texto directamente en la terminal.
gpg --output doc_cifrado.txt --encrypt --recipient condorjeniffer0@gmail.com doc_no_cifrado.txt # usamos el hash o correo de la clave publica de nuestro compa para cifrar el documento
