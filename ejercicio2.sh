touch prueba.txt
#Creates an empty file called prueba.txt

chmod 600 prueba.txt
#Sets permissions to:
# owner: read and write (rw-)
# group: no permissions 
# others: no permissions 
#Only the owner can read and modify the file.

ls -l prueba.txt
#Shows file permissions

chmod 755 prueba.txt
#Sets permissions to:
# owner: read, write, execute (rwx)
# group: read and execute (r-x)
# others: read and execute (r-x)
# Now everyone can read it, but only the owner can modify it.

ls -l prueba.txt
# Shows file permissions

