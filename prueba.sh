#History
    1  mv nebula/registros nebula/bitacoras
    2  ls nebula/
    3  ls -l nebula/
    4  find . -type d | sort
    5  cd nebula
    6  ls -l
    7  mkdir registros
    8  mv registros bitacoras
    9  mkdir borradores
   10  git add .
   11  git commit -m "Fix problema 1: estructura de directorios corregida"
   12  git add .
   13  git commit -m "Fix problema 1: estructura de directorios corregida"
   14  mv nebula/cosmos.txt nebula/bitacoras/
   15  mv cosmos.txt bitacoras 
   16  mv estrella.bak estrella.conf
   17  git add .
   18  git commit -m "Fix problema 2: archivos movidos y renombrados"
   19  chmod 640 nebula/bitacoras/cosmos.txt
   20  chmod 640 cosmos.txt
   21  chmod 640 nebula/bitacoras/cosmos.txt
   22  ls nebula/
   23  pwd
   24  chmod 640 cosmos.txt
   25  ls -la
   26  chmod 640 bitacoras/cosmos.txt
   27  ls -l bitacoras/cosmos.txt
   28  git add . 
   29  git commit -m "Fix problema 3: permisos numericos 640 en cosmos.txt"
   30  chmod u+x nebula/galaxia.sh
   31  chmod u+x galaxia.sh
   32  ls -l galaxia.sh
   33  chmod o-w estrella.conf
   34  ls -l estrella.conf
   35  git add . 
   36  git commit -m "Fix problema 4: permisos simbolicos corregidos"
   37  chmod u+s galaxia.sh
   38  ls -l galaxia.sh
   39  git add . 
   40  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   41  git add . 
   42  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   43  ls -ld /tmp/nebula_zone
   44  mkdir -p /tmp/nebula_zone
   45  chmod +t /tmp/nebula_zone
   46  ls -ld /tmp/nebula_zone
   47  chmod o+x /tmp/nebula_zone
   48  ls -ld /tmp/nebula_zone
   49  git add . 
   50  git commit -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   51  git add . 
   52  git commit -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   53  gpg --full-generate-key
   54  history
   55  gpg --full-generate-key
   56  gpg --full-generate-key --pinentry-mode loopback
   57  gpg --list-keys
   58  gpg --encrypt --recipient aurora@nebula.lab bitacoras/cosmos.txt
   59  ls -l bitacoras/
   60  git add .
   61  git commit -m "Fix problema 7: llave GPG generada y cosmos.txt cifrado"
   62  gpg --clearsign estrella.conf
   63  gpg --verify galaxia.sh.sig galaxia.sh
   64  gpg --detach-sign galaxia.sh
   65  gpg --verify galaxia.sh.sig galaxia.sh
   66  git add . 
   67  git commit -m "Fix problema 8: firmas GPG corregidas y creadas"
   68  history