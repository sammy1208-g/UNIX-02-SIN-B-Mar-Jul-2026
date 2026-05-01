# Course - Linux
# Commands
ls
# stands for list. It is used to display the contents of a directory (files and folders). 
# By default, it shows the items in the current directory.

ls Documents
# This command lists the contents of the folder named Documents. 
# It shows all files and subfolders inside that directory.

aptitude moo
# This is a hidden “Easter egg” command in aptitude (a package manager on Linux).

ls -l 
# The -l option means long listing. It shows detailed information about each file and folder, such as:
# permissions (who can read/write/execute), number of links, owner (user)
# group, file size, last modification date, file or directory name.

ls -r
ls -lr
ls -l -r 
ls -rl
# The option means reverse order. It lists the files and directories in the opposite order of the default sorting 
# (usually alphabetical, Z → A).

aptitude -v moo
# This command adds the -v (verbose) option to the hidden Easter egg moo.
# Each time you increase the number of v (like -vv, -vvv).

pwd 
# Stands for print working directory. It shows the full path of the current directory you are in.

cd Documents
# means change directory.
# This command moves you into the Documents folder (inside your current directory).

cd /
# This command takes you to the root directory (/), 
# which is the top-level directory of the entire system.

cd /home/sysadmin
# This command changes your current directory to /home/sysadmin.
# It uses an absolute path (starting from /), so it takes you directly to that folder no matter where you are.

cd Documents # Changes your current directory to the Documents folder inside your current location.
cd School/Art # This command moves you into the Art folder, which is inside the School folder.
#It uses a relative path (based on your current location).
pwd # Stands for print working directory.
# Results: /home/sysadmin/Documents/School/Art

cd .. # This command moves you one level up in the directory structure (to the parent directory).

cd ~ #The ~ symbol represents your home directory.
# So cd ~ takes you directly to your personal folder, no matter where you are.

ls -l /var/log/
# This command lists the contents of the /var/log/ directory in long format.
# It shows detailed information about system log files, such as permissions, owner, size, and modification date.

ls -lt /var/long # This command lists the contents of /var/log in long format (-l) and sorts them by modification time (-t).
# The most recently modified files appear first.

ls -l -s /var/log # Displays the contents of the /var/log directory in detailed format,
# including permissions, owner, size, date, and file name. 
# Additionally, the -s option shows the disk space used by each file in blocks at the beginning of each line.

ls -lSr /var/log # Lists the contents of the /var/log directory in detailed format (-l), sorts them by file size (-S), and reverses the order (-r), so the smallest files appear first.

ls -r /var/log
# lists the contents of the /var/log directory in reverse order (usually Z → A). 
# It only shows the file and folder names without extra details.

sudo - # 
# 
exit # 

sl #

su - #

sl # 
exit # 

sudo sl # 

cd ~/Documents # Changes the current directory to the Documents folder inside your home directory.
ls -l hello.sh # shows detailed information about the file hello.sh. 
# It indicates that the file has read and write permissions for the owner (-rw-r--r--), belongs to the user and group sysadmin,
# size, modification date, and the file name.

./hello.sh # Runs the script file named hello.sh located in the current directory.
# Results: -bash: ./hello.sh: Permission denied
chmod u+x hello.sh # Gives the user (owner) permission to execute the file hello.sh, turning it into an executable script.
ls -l hello.sh # Shows the updated permissions so you can see that the execute (x) right has been added for the user.
# Results: -rwxr--r-- 1 sysadmin sysadmin 647 Dec 20  2017 hello.sh
./hello.sh # Runs the script file named hello.sh located in the current directory. The ./ tells the system to execute the file from “here” (current folder). 
# This works because the file now has execute permission (x) added using chmod.

ls -l # Shows detailed information about files in the current directory.
sudo chown root hello.sh # Changes the owner of the file hello.sh to root (administrator), so only root has full control of it.
ls -l hello.sh # Displays the updated file information, where you can see that the owner is now root.
# Results: -rwxr--r-- 1 root sysadmin 647 Dec 20  2017 hello.sh

./hello.sh # Run the script hello.sh from the current directory, and an error occurs because only the owner user has permission to execute.
# The root user is now the owner, and this file requires administrative access to run.
sudo ./hello.sh # Runs with administrator (root) privileges, allowing it to perform actions that normally require higher permissions.

cat animals.txt # Displays the entire content of the file animals.txt.
cat alpha.txt # Displays all the content of alpha.txt.
head alpha.txt # Shows the first 10 lines of the file.
tail alpha.txt # Shows the last 10 lines of the file.
head -n 5 alpha.txt # Shows the first 5 lines of the file alpha.txt. The -n 5 option specifies the number of lines to display.
tail -n 5 alpha.txt # Shows the last 5 lines of the file alpha.txt.

cp /etc/passwd . # Copies the file /etc/passwd (a system file that stores user account information) into the current directory (. means “here”).
ls # Then lists the files in the current directory, so you can see that the file passwd has been copied successfully.

cd ~ # Moves you to your home directory, no matter where you currently are.
dd if=/dev/zero of=/tmp/swapex bs=1M count=50 # Creates a file called swapex in /tmp filled with zeros. It uses dd to write 50 blocks of 1 MB each (bs=1M count=50), 
# resulting in a 50 MB file. /dev/zero is a special system source that provides continuous zero bytes.