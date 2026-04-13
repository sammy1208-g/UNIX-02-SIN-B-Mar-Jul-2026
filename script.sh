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
