# !/bin/bash
#!/bin/bash -x  # Muestra los comandos en tiempo real- Display commands in real time.
set -x # Enables trace mode. 

bash --version
env
echo ${SHELL}
echo ${RANDOM}
echo ${UID}
echo ${OSTYPE}
ps -e -f
ps -ef
df --human-readable
#bash -r blackhatbash1.sh # -r Para ejecutar modo restringido. For running restricted mode
#bash -n blackhatbash1.sh # -n muestra errores de sintaxis. Displays syntax errors, Debugging.
# bash -x blackhatbash1.sh # -x Activar modo verboso. Enable verbose mode.

set +x # Disables trace mode.