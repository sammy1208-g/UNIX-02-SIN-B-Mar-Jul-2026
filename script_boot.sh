cd # change directory / It takes you directly to your home directory.
cd /home/codespace #  It moves you to a specific path.
cd ~ # It is a shortcut for your home directory.
cd $HOME # It is an environment variable that stores your home directory path
mkdir proyecto # Creates a new directory (folder) called proyecto.
cd proyecto/ # Moves into the proyecto directory
ls -lai # Lists files  / Shows hidden files (like . and ..) . Current directory / .. Parent Directory
#Results : 
#total 12
# 925550 drwxr-xr-x 2 codespace codespace 4096 Apr  6 12:35 .
# 918515 drwxr-x--- 1 codespace codespace 4096 Apr  6 12:35 ..
stat .  # Shows detailed information about the current directory (.)
#Results 
#   Size: 4096            Blocks: 8          IO Block: 4096   directory
#Device: 0,45    Inode: 925550      Links: 2
#Access: (0755/drwxr-xr-x)  Uid: ( 1000/codespace)   Gid: ( 1000/codespace)
#Access: 2026-04-06 12:35:58.920507646 +0000
#Modify: 2026-04-06 12:35:44.541507445 +0000
# Change: 2026-04-06 12:35:44.541507445 +0000
#Birth: 2026-04-06 12:35:44.541507445 +0000
# Device : 0,45 / Identifier of the storage device
mkdir -p /tmp/prueba/sub1 /tmp/prueba/sub2 # Creates directories recursively (including parent folders if they don’t exist).
stat /tmp/prueba # Shows detailed information about the prueba directory
# Results:
#  Size: 4096            Blocks: 8          IO Block: 4096   directory
#Device: 8,1     Inode: 1179663     Links: 4
#Access: (0756/drwxr-xrw-)  Uid: ( 1000/codespace)   Gid: ( 1000/codespace)
#Access: 2026-04-06 12:52:52.526521831 +0000
#Modify: 2026-04-06 12:52:52.527521831 +0000
#Change: 2026-04-06 12:52:52.527521831 +0000
#Birth: 2026-04-06 12:52:52.526521831 +0000
#Device:  8,1 / Storage device ID
man mkdir -p /tmp/prueba/sub1 /tmp/prueba/sub2 # This open the manual 
