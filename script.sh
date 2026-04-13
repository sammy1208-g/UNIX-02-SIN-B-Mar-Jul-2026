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


