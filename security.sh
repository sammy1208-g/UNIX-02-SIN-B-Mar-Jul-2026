# Commands

id 
# It displays information about the user who is currently using the system.

cat /etc/passwd | head -10
# This command displays only the first 10 lines of the system's /etc/passwd file for system users.

groups
# The `groups` command (`groups`) displays the groups to which the current user belongs.

groups $USER 
# It displays the groups, but specifies the user using a variable; the $ symbol indicates that a system variable is being used. 
# `$USER` contains the current user's name.

id -u # Displays only the current user's UID
id -g # Displays the user's primary GID.
id -G # It displays all the GIDs of the groups to which the user belongs.

cat /etc/group | grep codespace # Displaying only the lines in the groups file that contain the word "codespace" will result in an error because that directory is not present.
#Results: cat: etc/group: No existe el fichero o el directorio

cat /etc/group # Displaying the entire contents of the system's groups file, that is, showing the complete list of existing groups.
#Results 
# src:x:40:
# shadow:x:42:
# utmp:x:43:
# video:x:44:
# sasl:x:45:
# plugdev:x:46:
# staff:x:50:
# games:x:60:
# users:x:100:
#.....
# Choose one

cat /etc/group | grep users # Displaying only the system groups that contain the word "user".
#Results:  users:x:100:

cat /etc/gshadow # Display protected information about system groups.
#Results:
# root:*::
#daemon:*::
#bin:*::
#sys:*::
#adm:*::
#tty:*::
#disk:*::
#lp:*::
#ews:*::
# ....

mkdir ~/proyecto_unix/ # This command creates a folder called project_unix inside your home directory.

ls -la ~/proyecto_unix/ #This command allows you to view detailed information about everything inside the project_unix folder (permissions, owner, size, date), including hidden files.
#Results: 
# total 8
# drwxr-xr-x 2 root root 4096 may  4 13:38 .
# drwx------ 1 root root 4096 may  4 13:38 ..

# groupadd [options] name_group
#Create a simple group
# When an identificator is less than 1000, it's an system identificator
sudo groupadd desarrolladores
sudo groupadd -g 2000 operaciones # specific GID
# group system (GID < 1000)
sudo groupadd --system servicios_web

#Verify that they were create
grep "desarrolladores\|operaciones\|servicios_web" /etc/group
grep -E "desarrolladores|operadores|servicios_web" /etc/group
# View main options
groupadd --help

# View the range of GIDs range in the system
grep "GID_MIN\|GID_MAX\|SYS_GID" /etc/login.defs
# System groups have GID less than the minimum user
#In Ubuntu, typicallly: 
#SYS_GID_MIN = 100
#SYS_GID_MAX = 999
#GID_MIN = 1000
#GID_MAX = 60000

# addgroup [options] name_group
#Create groups with "addgroup"
sudo addgroup diseno
sudo addgroup --gid 2100 marketing
sudo addgroup --system cache_web
#Verify
grep "diseno\|marketing\|cache_web" /etc/group

#View which groups the currents user belongs to
groups
id
#Add a user to group with "usermod" (low level)
sudo usermod -aG desarrolladores $USER
sudo usermod -aG diseno $USER

#Solution: 
# Ser root
 usermod -aG desarrolladores root
 usermod -aG diseno root
 #Verify 
 groups
 id
 id root

# Verify the change in /etc/group
grep "desarrolladores\|diseno"

#Add a user to a group with "adduser".
sudo adduser root marketing
#View the current status
id root
grep root /etc/group

# Create new temporary group for the demo
sudo groupadd grupo_temporal
usermod -aG grupo_temporal root
id root # Have a grupo_temporal

#Now the error: usermod without -a
sudo usermod -G desarrolladores root
#This removes all child groups except "Developers"

id root #Lost all other groups

#Restore
 sudo usermod -aG diseno,marketing,grupo_temporal root
 id root # Restored

# Preparate the practice scenario
# * -p ( parent)
mkdir -p ~/lab_chgrp/{proyectos,reportes,scripts}
touch ~/lab_chgrp/proyectos/app.py
touch ~/lab_chgrp/proyectos/config.json
touch ~/lab_chgrp/reportes/informe.txt
touch ~/lab_chgrp/scripts/deploy.sh

#View initial state
ls -la ~/lab_chgrp/proyectos/
ls -la ~/lab_chgrp/reportes/

#Change the group of file
sudo chgrp desarrolladores ~/lab_chgrp/proyectos/app.py
ls -la ~/lab_chgrp/proyectos/

# Change the group of multiple files
sudo chgrp diseno \
 ~/lab_chgrp/proyectos/config.json \
 ~/lab_chgrp/reportes/informe.txt
ls -la ~/lab_chgrp/proyectos/
ls -la ~/lab_chgrp/reportes/

# Recursively change an entire directory
sudo chgrp -R desarrolladores ~/lab_chgrp/scripts/ 
ls -laR ~/lab_chgrp/scripts/

# Verbose to see what changes
 sudo chgrp -Rv diseno ~/lab_chgrp/reportes/