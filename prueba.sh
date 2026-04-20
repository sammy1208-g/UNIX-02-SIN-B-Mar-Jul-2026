#Historial de comando
git branch -a
    2  git clone https://crispy-enigma-97g4rgv4r4p9394x6.github.dev/
    3  git clone https://github.com/sammy1208-g/UNIX-02-SIN-B-Mar-Jul-2026
    4  cd UNIX-02-SIN-B-Mar-Jul-2026
    5  git brain -a
    6  git branch -a
    7  git checkout eval_p2_1_v1
    8  git remote -v
    9  clean
   10  git remote add stream https://github.com/jonathanetitoo/UNIX-02-SIN-B-Mar-Jul-2026.git
   11  git remote -v
   12  git fetch upstream
   13  git checkout -b eval_p2_1_v1 upstream/eval_p2_1_v1
   14  git push -u origin eval_p2_1_v1
   15  mv nebula/registros nebula/bitacoras
   16  ls nebula/
   17  ls -l nebula/
   18  mkdir nebula/bitacoras
   19  mkdir nebula/borradores
   20  ls nebula/
   21  git add .
   22  git commit -m "Fix problema 1 :estructura de directorios corregida"
   23  git commit -m "Fix problema 1: estructura de directorios corregida"
   24  ls nebula/
   25  git add nebula/
   26  git commit -m "Fix problema 1: estructura de directorios corregida"
   27  git log --oneline
   28  ls nebula/
   29  git add nebula/bitacoras nebula/borradores
   30  git commit -m "Fix problema 1: estructura de directorios corregida"
   31  git log --oneline
   32  touch nebula/bitacoras/.gitkeep
   33  touch nebula/borradores/.gitkeep
   34  git add nebula/bitacoras/.gitkeep nebula/borradores/.gitkeep
   35  git commit -m "Fix problema 1: estructura de directorios corregida"
   36  git log --oneline
   37  mv nebula/cosmos.txt nebula/bitacoras/
   38  mv nebula/estrella.bak nebula/estrella.conf
   39  ls nebula/
   40  ls nebula/bitacoras/
   41  git add .
   42  git commit -m "Fix problema 2: archivos movidos y renombrados"
   43  ls nebula/bitacoras/
   44  chmod 640 nebula/bitacoras/cosmos.txt
   45  ls -l nebula/bitacoras/cosmos.txt
   46  git add nebula/bitacoras/cosmos.txt
   47  git commit -m "Fix problema 3: permisos numericos 640 en cosmos.txt"
   48  git log --oneline
   49  chmod u+x nebula/galaxia.sh
   50  chmod o-w nebula/estrella.conf
   51  ls -l nebula/galaxia.sh nebula/estrella.conf
   52  chmod g-x,o-x nebula/galaxia.sh
   53  chmod g-w,o-w nebula/galaxia.sh
   54  chmod o-w nebula/estrella.conf
   55  ls -l nebula/galaxia.sh nebula/estrella.conf
   56  git add .
   57  git commit -m "Fix problema 4: permisos simbolicos corregidos"
   58  chmod u+s nebula/galaxia.sh
   59  ls -l nebula/galaxia.sh
   60  git add nebula/galaxia.sh
   61  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   62  git add . 
   63  git commit -m "Fix problema 5: SUID activado en galaxia.sh"
   64  chmod +t /tmp/nebula_zone
   65  mkdir -p /tmp/nebula_zone
   66  chmod +t /tmp/nebula_zone
   67  ls -ld /tmp/nebula_zone
   68  chmod u+x /tmp/nebula_zone
   69  ls -ld /tmp/nebula_zone
   70  git add .
   71  git commit -m "Fix problema 6: sticky bit en /tmp/nebula_zone"
   72  gpg --full-generate-key
   73  history