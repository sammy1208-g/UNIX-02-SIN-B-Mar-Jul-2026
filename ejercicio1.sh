echo '#!bin/sh' > hola.sh
# Create a new file: hola.sh

echo 'echo "Hola desde mi primer script"' >> hola.sh
# This command creates or modifies a file called hola.sh and appends a line of text to it.

cat hola.sh
# Shows content 

./hola.sh
#runs the script hola.sh from the current directory (./).
#Results: bash: ./hola.sh: Permission denied

#Permissions
ls -l hola.sh # Shows detailed info about hola.sh, including permissions, owner, size, and date. At this point, it does not have execute permission.
#Results:-rw-rw-rw- 1 codespace codespace 44 Apr 15 13:07 hola.sh
chmod +x hola.sh # Adds execute permission to the file.
ls -l hola.sh # Now you will see x in permissions, meaning the file is executable.
#Results: -rwxrwxrwx 1 codespace codespace 44 Apr 15 13:07 hola.sh
./hola.sh # Run the script
#Results: hola desde mi primer script




