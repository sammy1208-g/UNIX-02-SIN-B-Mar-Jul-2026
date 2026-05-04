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