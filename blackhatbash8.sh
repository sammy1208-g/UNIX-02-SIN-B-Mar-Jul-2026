#!/bin/bash
awk '{print $1,$2,$3}' log.txt

awk '{print $1}' log.txt
awk '{print $2}' log.txt
awk '{print $3}' log.txt

awk '{print $1,$NF}' log.txt


awk -F',' '{print $1}' example_csv.txt

awk 'NR < 10' log.txt
#Shows 10 lines

grep "42.236.10.117" log.txt | awk '{print $7}'


sed 's/Mozilla/Godzilla/g' log.txt

sed 's/Mozilla/Godzilla/g' log.txt > newlog.txt


sed -i 's/Mozilla/Godzilla/g' log.txt

sed 's/ //g' log.txt > newlog1.txt

sed '1d' newlog.txt > newlogd.txt

sed '$d' newlog.txt > newlogl.txt

sed '5,7d' newlog.txt > newlog57.txt

sed -n '2,15 p' log.txt

sed -i '1d' log.txt

sleep 100 &
# [1] 24169

ps -ef | grep sleep
# root           1       0  0 12:10 ?        00:00:01 /bin/sh -c echo Container started trap "exit 0" 15  exec "$@" while sleep 1 & wait $!; do :; done -
# root       24169     372  0 13:10 pts/0    00:00:00 sleep 100
# root       24260       1  0 13:10 ?        00:00:00 sleep 1
# root       24263     372  0 13:10 pts/0    00:00:00 grep --color=auto sleep

jobs 
# [1]+  Ejecutando                 sleep 100 &

fg %1
# sleep 100
# Ctrl + Z
# [1]+  Detenido                   sleep 100

bg %1
# [1]+ sleep 100 &

nohup ./ejercico2.sh blackhatbash &
# [1] 29709
# nohup: se descarta la entrada y se añade la salida a 'nohup.out'
# nohup: fallo al ejecutar la orden './ejercicio2.sh blackhatbash': Permiso denegado
# [1]+  Salida 126                 nohup ./ejercicio2.sh blackhatbash

chmod u+x ejercicio2.sh

