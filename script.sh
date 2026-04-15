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
