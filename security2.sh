# See the current parent group 
id
id -gn # Only name of main group
#Create file and see which group inherits
touch ~/test_grupo_heredado.txt
ls -la ~/test_grupo_heredado.txt
# Results
# -rw-r--r-- 1 root root 0 may 27 12:56 /root/test_grupo_heredado.txt
# The group is the main group of user.

# See the current parent group
id -gn
echo "Grupo actual: $(id -gn)"

#Create file before newgrp
touch ~/antes_de_newgrp.txt
ls -la ~/antes_de_newgrp.txt
#Results
# -rw-r--r-- 1 root root 0 may 27 13:06 /root/antes_de_newgrp.txt

#Change to the group "developers"
newgrp desarrolladores
#Error: 
#Solution 
# apt install util-linux-extra
# groupadd desarrolladores
# usermod -aG desarrolladores root
# groups : root desarrolladores
# newgrp desarrolladores

#Verify that the active group has changed
id -gn
echo "Nuevo grupo activo: $(id -gn)"
#Results 
# Nuevo grupo activo: desarrolladores

#Create a file inside the subshell.
touch ~/dentro_de_newgrp.txt
ls -la ~/dentro_de_newgrp.txt
# Results:
# -rw-r--r-- 1 root desarrolladores 0 may 27 13:29 /root/dentro_de_newgrp.txt

#The group is now developers
# Create a directory
mkdir -p ~/proyecto_dev/src
ls -la ~/
# Results:
#total 68
#drwx------ 1 root root             4096 may 27 13:30 .
#drwxr-xr-x 1 root root             4096 may 27 12:46 ..
#-rw-r--r-- 1 root root                0 may 27 13:06 antes_de_newgrp.txt
#-rw-r--r-- 1 root root             5578 may 24 04:01 .bashrc
#-rw-r--r-- 1 root root              607 may 24 04:01 .bashrc.original
#drwxr-xr-x 3 root root             4096 may 27 12:46 .cache
#drwx------ 3 root root             4096 may 27 12:46 .config
#-rw-r--r-- 1 root desarrolladores     0 may 27 13:29 dentro_de_newgrp.txt
#lrwxrwxrwx 1 root root               47 may 27 12:46 .docker -> /workspaces/.codespaces/.persistedshare/.docker
#drwxr-xr-x 3 root root             4096 may 27 12:46 .dotnet
#drwx------ 4 root root             4096 may 27 12:46 .local
#-rw-r--r-- 1 root root              132 may 15 11:37 .profile
#drwxr-xr-x 3 root desarrolladores  4096 may 27 13:30 proyecto_dev
#drwx------ 2 root root             4096 may 27 12:45 .ssh
#-rw-r--r-- 1 root root                0 may 27 12:56 test_grupo_heredado.txt
#drwxr-xr-x 5 root root             4096 may 27 12:46 .vscode-remote
#-rw------- 1 root root              519 may 27 13:13 .zsh_history
#-rw-r--r-- 1 root root            10976 may 27 12:46 .zshrc

#proyecto_dev/ has group "developers"
#Exit the newgrp subshell
exit
#Verify that we returned to the original group
id -gn 
#Results:
#root
echo "Grupo restaurado: $(id -gn)"
# Results
# Grupo restaurado: root
                                                         