ls -a # Short option
ls --all # Long option
ls -a / 
# Command, option, arguments
# Command (ls) Lists the contents of a directory.
#Option (-a) Shows all files, including hidden files.
#Arguments (/) Refers to the root directory.

ls -l -a -h # Long option
# ls : Lists files
# -l : Uses long format (permissions, size, date, etc.)
#-a : Shows all files, including hidden files
#-h : Shows sizes in human-readable format (KB, MB)
ls -l -ah # long option
ls -lah # Short option

#Creates a directory named -rf.
mkdir -- -rf
#mkdir: Creates a directory
# -- : Stops option parsing (everything after this is treated as a name, not an option)
# -rf : The name of the directory to create (“-rf”)

#Removes the directory named -rf (only if it is empty).
rmdir -- -rf
# rmdir : Removes an empty directory
# -- : Stops option parsing
# -rf : The directory name to remove

ls --help # Short option / Shows a help message with all available options of ls.
mal ls # Long option / Opens the full manual page for ls with detailed explanations.

man git-clone # Opens the manual page for git clone, explaining how to copy (clone) a repository, its options, and usage.
--depth # 
#[--depth <depth>] [--[no-]single-branch] [--no-tags]
#                [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
#                [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
#                [--filter=<filter> [--also-filter-submodules]] [--] <repository>
#                [<directory>]

#--depth <depth>
#          Create a shallow clone with a history truncated to the specified number of commits. Implies --single-branch unless --no-single-branch is given to fetch the histories
#          near the tips of all branches. If you want to clone submodules shallowly, also pass --shallow-submodules.

chmod +x script.sh # Execute permission is added to user, group, and others
ls -l # 
#Results: -rwxrwxrwx 1 codespace codespace  1936 Apr 13 13:11 script.sh
chmod u+x script.sh # Adds execute permission only to the user (owner)
ls -l 
#Results: Only user gets execute permission 
# -rwxrwxrwx 1 codespace codespace  1936 Apr 13 13:11 script.sh
chmod o-r script.sh # Removes read permission from others
ls -l
#Results: Others can’t read the file
# -rwxrwx-wx 1 codespace codespace  2190 Apr 13 13:15 script.sh
chmod u+rw,go-rwx script.sh
# u+rw: user gets read & write
# go-rwx: group & others lose all permissions
ls -l
#Results: Only user can read/write, no one else has access
# -rwx------ 1 codespace codespace  2262 Apr 13 13:16 script.sh


sudo echo "hola" > /etc/archivo_protegido
#Results
# bash: /etc/archivo_protegido: Permission denied
#The error happens because the > redirection is handled by your shell, not by sudo. Your shell runs without elevated privileges, so it cannot write to /etc.

echo "hola" | sudo tee /etc/archivo_protegido > /dev/null
#The command writes "hola" into a protected file using admin privileges, without printing anything to the terminal.

#Read and display the file archivo_protegido content in the terminal.
cat /etc/archivo_protegido

echo "hola" | sudo tee /etc/archivo_protegido
#It writes to a protected file with admin privileges and also prints the text.

sudo sh -c 'echo "chao" >> /etc/archivo_protegido'
# Runs everything as root and uses >> to append (not overwrite) "chao" to the file.

cat /etc/archivo_protegido
# Display the content: hola, chao

sudo su -
#This command switches you to a full root user session.
exit
#This command to leave the current session. 

echo "$HOME"
#Results: /home/codespace
#expands the variable

echo '$HOME'
#Results: $HOME
#Anything inside the single quote is treated as a string. 

umask # umask is a value that removes permissions from new files and directories by default.
#Results : 0022

touch archivo1 # Creates an empty file called archivo1.
mkdir directorio1 # Creates a directory (folder) called directorio1.
ls -l # Lists files in long format (detailed view).
#total 60
#-rw-rw-rw-  1 codespace root      34523 Apr 27 12:07 LICENSE
#-rw-rw-rw-  1 codespace root         70 Apr 27 12:07 README.md
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:33 archivo1
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:34 directorio1
#-rw-rw-rw-  1 codespace root       1262 Apr 27 12:07 ejercicio1.sh
#-rw-rw-rw-  1 codespace root        522 Apr 27 12:07 ejercicio2.sh
#-rwxrwxrwx  1 codespace root         44 Apr 27 12:07 hola.sh
#-rwxrwxrwx  1 codespace root          0 Apr 27 12:07 prueba.txt
#-rwxrwxrwx  1 codespace root       3819 Apr 27 12:33 script.sh

umask 027 # sets a more restrictive permission mask
touch archivo2 # creates an empty file: archivo2
mkdir directorio2 # creates a directory
ls -l # shows detailed listing
#Results
# total 68
#-rw-rw-rw-  1 codespace root      34523 Apr 27 12:07 LICENSE
#-rw-rw-rw-  1 codespace root         70 Apr 27 12:07 README.md
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:33 archivo1
#-rw-rw-rw-  1 codespace codespace     0 Apr 27 12:37 archivo2
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:34 directorio1
#drwxrwxrwx+ 2 codespace codespace  4096 Apr 27 12:37 directorio2
#-rw-rw-rw-  1 codespace root       1262 Apr 27 12:07 ejercicio1.sh
#-rw-rw-rw-  1 codespace root        522 Apr 27 12:07 ejercicio2.sh
#-rwxrwxrwx  1 codespace root         44 Apr 27 12:07 hola.sh
#-rwxrwxrwx  1 codespace root          0 Apr 27 12:07 prueba.txt
#-rwxrwxrwx  1 codespace root       4572 Apr 27 12:36 script.sh

sudo apt-get update # updates package list
sudo apt-get upgrade # upgrades installed packages
sudo apt-get install acl # installs ACL support (advanced permissions)
sudo chown -R $(whoami) . # changes ownership to current user 
sudo setfacl -bnR . # removes all ACLs recursively
 

umask 077 # very restrictive (no access for others)
touch secrecto.txt # creates file: secreto.txt
mkdir privado # creates directory
ls -l # shows permissions
#Results
#-rw-rw-rw- 1 codespace root         70 Apr 27 12:07 README.md
#-rw-rw-rw- 1 codespace codespace     0 Apr 27 12:33 archivo1
#-rw-rw-rw- 1 codespace codespace     0 Apr 27 12:37 archivo2
#drwxrwxrwx 2 codespace codespace  4096 Apr 27 12:34 directorio1
#drwxrwxrwx 2 codespace codespace  4096 Apr 27 12:37 directorio2
#-rw-rw-rw- 1 codespace root       1262 Apr 27 12:07 ejercicio1.sh
#-rw-rw-rw- 1 codespace root        522 Apr 27 12:07 ejercicio2.sh
#-rwxrwxrwx 1 codespace root         44 Apr 27 12:07 hola.sh
#drwx------ 2 codespace codespace  4096 Apr 27 13:06 privado
#-rwxrwxrwx 1 codespace root          0 Apr 27 12:07 prueba.txt
#-rwxrwxrwx 1 codespace root       5644 Apr 27 13:11 script.sh
#-rw------- 1 codespace codespace     0 Apr 27 13:05 secreto.txt

umask 0022 # sets the permission mask
whoami  # shows your current user
echo "Hola" > mi_archivo # creates the file and writes “Hola”
ls -l mi_archivo # shows permissions
umask # Confirms the mask → 0022
#Result: 
# 0022

sudo useradd -m -s /usr/bin/zsh luna # Creates a new user named luna and sets the shell to Zsh
sudo chown luna mi_archivo # Changes the owner of mi_archivo to luna
ls -l mi_archivo # Shows detailed information about the file mi_archivo.

groups 
groupadd grupo_test


sudo chown luna:grupo_test mi_archivo # changes both owner and group of the file
ls -l mi_archivo # Shows file details (permissions, owner, group, etc.) 
#Results:
# -rw-r--r-- 1 luna grupo_test 5 Apr 27 13:49 mi_archivo