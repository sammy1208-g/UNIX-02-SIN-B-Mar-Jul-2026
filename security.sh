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