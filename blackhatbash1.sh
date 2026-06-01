# !/bin/bash
#!/bin/bash -x  # Muestra los comandos en tiempo real- Display commands in real time.

bash --version
env
echo ${SHELL}
echo ${RANDOM}
echo ${UID}
echo ${OSTYPE}
ps -e -f
ps -ef
df --human-readable
bash -r blackhatbash1.sh # -r Para ejecutar modo restringido. for running restricted mode