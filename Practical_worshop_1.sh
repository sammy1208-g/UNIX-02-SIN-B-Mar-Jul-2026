uname -a
which gpg
gpg --version
gpg --full-generate-key  # generar clave
gpg --list-keys
gpg --armor --export chamorrosamy525@gmail.com > mi_llave publica.asc
ls mi_llave_publica.asc
gpg --armor --export
gpg --list-secret-keys --keyid-format=long #para listar las llaves privadas
# 23909E79DC4B0DF0
gpg --armor --export-secret-keys # para especificar el hash de las llaves
gpg --import JENNIMICOMPA_llave_publica.asc # compartir llave
gpg --list-keys # listar llaves de mi compa