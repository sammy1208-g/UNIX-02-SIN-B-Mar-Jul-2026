uname -a # Provides complete operating system information  / respuesta: Linux codespaces-dd4d4b 6.8.0-1044-azure #50~22.04.1-Ubuntu SMP Wed Dec  3 15:13:22 UTC 2025 x86_64 x86_64 x86_64 GNU/Linux
which gpg # Tells us where GPG is installed / respuesta: /usr/bin/gpg
gpg --version # # Displays the installed GPG version / respuesta : gpg (GnuPG) 2.4.4 ....
gpg --full-generate-key # generate key
gpg --list-keys # List keys
gpg --armor --export chamorrosamy525@gmail.com > mi_llave publica.asc # It exports the public key and saves it to an .asc file.
ls mi_llave_publica.asc # verifies that the file has been created
gpg --armor --export # Export public key
gpg --list-secret-keys --keyid-format=long # To list private keys
gpg --armor --export-secret-keys  # To specify the hash of the keys
# gpg --pinentry-mode loopback --armor --export-secret-keys C942833FAF2766C1  / EN MICASO NO ME VALIO  EL ANTERIOR COMANDO Y APLIQUE ESTE COMANDO PARA QUE FUNIONARA Y ME SALIERA MI LLAVE PRIVADA.
# The command allows you to export the private key in ASCII format, using loopback mode to enter the password directly in the terminal, which is useful in environments without a graphical interface.
# We create an .asc file with our friend's public key
gpg --import JenniMICOMPA_llave_publica.asc  #  Share key 
gpg --list-keys # List my friend's keys
$ echo "este mensaje es secreto" > doc_no_cifrado.txt # Save a message for our friend, in this case "this message is secret"
ls # Display file and folder names.
cat doc_no_cifrado.txt # Displays the contents of a text file directly in the terminal.
gpg --output doc_cifrado.txt --encrypt --recipient condorjeniffer0@gmail.com doc_no_cifrado.txt # We use our friend's public key hash or email to encrypt the document
gpg --decrypt JMICOMPA_doc_cifrado.txt # Decrypt the document sent by our friend
gpg --output doc_no_cifrado_firmado.txt --clearsign doc_no_cifrado.txt # Firmar archivo 
ls # View files
cat doc_no_cifrado_firmado.txt # Allows you to view the file contents (including the signature)
gpg --verify JEMICOMPA_doc_no_cifrado_firmado.txt # It is used to verify the authenticity and integrity of the signed file
gpg --edit-key condorjeniffer0@gmail.com  # Give your friend a vote of confidence; it is also used to manage and modify a GPG key from the terminal.
gpg --sign-key C970546ABAFA2BE1 #  Sign the key to ratify our decision.
gpg --verify JEMICOMPA_doc_no_cifrado_firmado.txt # It is used to verify the authenticity and integrity of the signed file
gpg --output doc_no_cifrado_firmado_binario.txt --sign doc_no_cifrado.txt # Sign the file and generate a signed binary version to ensure authenticity and integrity.
gpg --verify JENMICOMPA_doc_no_cifrado_firmado_binario.txt # This is used to verify the authenticity and integrity of a file signed in binary format.
gpg --output firma_separada_doc_no_cifrado.sig --detach-sign doc_no_cifrado.txt # Sign the document and we will separate the signature from the document.
gpg --verify JENMICOMPA_firma_separada_doc_no_cifrado.sig JMICOMPA_doc_no_cifrado.txt # Verifies a separate digital signature of our friend.