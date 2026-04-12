El sistema que vamos a construir tiene tres componentes:

1. **Kernel Linux** - El núcleo del sistema operativo
2. **BusyBox** -Proporciona las utilidades básicas de Unix (ls,pwd, vi, etc.) en un solo binario
3. **Syslinux** - El bootloader que carga todo al arrancar

sudo apt update 
sudo apt upgrade
sudo apt install -y git vim make gcc libncurses-dev flex bison bc cpio libelf-dev libssl-dev syslinux dosfstools qemu-system-x86  

**Para qué sirve cada paquete?**

- `gcc`, `make` -Compilación del Kernel y BusyBox
- `libncurses-dev` -Menus interactivos de configuracion (`menuconfig`)
- `flex`, `bison`, `bc` - Requeridos por el proceso de build del kernel
- `cpio`, -Para crear el inittramfs
- `libelf-dev`, `libssl-dev`- Dependencias del kernel
- `syslinux` - El booloader
- `dosftstools` - Para crear el filesystem FAT
- `qemu-system-86` -Para probar la imagen sin necesidad de hadware real

Clona el repositorio del kernel ( solo el ultimo comm)
 git clone --depth 1 https://github.com/torvals/linux.git
cd linux
make menuconfig
make -j 2

Imagen del Proyecto: 

# Lists the file arch/x86/boot/bzImage to check if the compiled kernel exists.
ls arch/x86/boot/bzImage 

# Creates the directory /boot-files with superuser (root) privileges.
sudo mkdir /boot-files

# Copies the bzImage file to the /boot-files/ directory with superuser (root) privileges.
sudo cp arch/x86/boot/bzImage /boot-files/

# Moves to the parent directory
cd ..

# Clones the BusyBox repository with minimal history (--depth 1) from the given URL.
git clone --depth 1 https://git.busybox.net/busybox

# Changes into the busybox directory.
cd busybox

# Opens the interactive configuration menu for BusyBox to customize its build options.
make menuconfig

# Compiles the project using 2 parallel jobs to speed up the build.
make -j 2

# It showed errors related to tc, so the .config file was edited with the command "vim .config".
# The line CONFIG_TC=y was located, and to edit it, the letter "i" was typed and changed to CONFIG_TC=n. Then, make -j 2 was run again.

# Creates the /boot-files/initramfs directory with superuser (root) privileges.
sudo mkdir /boot-files/initramfs

# Runs make install as root, installing the compiled files (BusyBox) into the initramfs directory /boot-files/initramfs using CONFIG_PREFIX.
sudo make CONFIG_PREFIX=/boot-files/initramfs install

# Changes to the /boot-files/initramfs directory. 
cd /boot-files/initramfs

# Creates the file init in the Vim editor with superuser (root) privileges.
sudo vim init 

# Inside "sudo vim init" we write the following:
# !/bin/sh
# /bin/sh
# The first line tells the kernel to use the shell to interpret the file. The second line starts a shell in interactive mode.

# Removes the file linuxrc with superuser (root) privileges.
sudo rm linuxrc 

# Gives execute permission to the init file with root privileges.
sudo chmod +x init

# Display the contents of the init script for verification
cat init

# Finds all files and packages them into a cpio archive in newc format, saving it as ../init.cpio with root privileges.
sudo find . | cpio -o -H newc > ../init.cpio
# The command didn't work because I was denied permission: " bash: ../init.cpio: Permission denied"
# To fix this, run the following command: sudo sh -c "find . | cpio -o -H newc > ../init.cpio"
# The first command didn't work because sudo doesn't apply to redirection (>), so the file was attempted to be created without permissions, and by using sudo sh -c I made the whole command (including the redirection) run as root.

# Moves one directory up to return to /boot-files.
cd ..

# Verify that the initramfs archive was created successfully
ls

# Switch to the root user for the following steps, to simplify permission management
sudo su

# Create an empty 50 MB file that will function as a virtual disk.
dd if=/dev/zero of=boot bs=1M count=50

# Create a FAT file system within that file, as it is necessary to use Syslinux.
mkfs -t fat boot

# Install the Syslinux bootloader on the image
syslinux boot

#  Creates a directory named m / Assemble the image
mkdir m

# Mounts the boot filesystem or image into the directory m. / Assemble the image
mount boot m

# Copies the files bzImage and init.cpio into the directory m.
cp bzImage init.cpio m

# Unmounts the filesystem from the directory m.
umount m

# Runs a virtual machine with QEMU without graphics (-nographic), boots using the bzImage kernel and init.cpio initramfs, passes the console to ttyS0, and uses boot as a raw disk image.
qemu-system-x86_64 -nographic -append "console=ttyS0" \
-kernel bzImage -initrd init.cpio -drive file=boot,format=raw

# EXERCISES

# 1
[ -d /sys/firmware/efi ] && echo "UEFI" || echo "BIOS"
# Results 
BIOS
# The result is BIOS because GitHub Codespaces runs in a virtualized environment that does not expose UEFI firmware. Similarly, QEMU also uses a legacy BIOS by default unless explicitly configured to use UEFI. This confirms that both environments simulate a traditional boot process.

# 2
ls /
# Results
bin   dev   init  root  sbin  usr
# The filesystem structure is minimal and only includes essential directories such as /bin, /sbin, /usr, /dev, and /root, along with the init file. Many standard directories like /home, /var, /tmp, and /etc are missing because this system is based only on BusyBox and a custom initramfs, not a full Linux distribution. This demonstrates how a minimal Linux system can operate with only the essential components required for booting and basic interaction.

# 3
ls -la /bin/
# Results
Total 2440 
drwxr-xr-x    2 0        0             1920 Apr 12 01:28 .
drwxr-xr-x    7 0        0              180 Apr 12 04:15 ..
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 arch -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 ash -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 base32 -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 base64 -> busybox
-rwxr-xr-x    1 0        0          2497624 Apr 12 01:28 busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 cat -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 chattr -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 chgrp -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 chmod -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 chown -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 conspy -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 cp -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 cpio -> busybox
lrwxrwxrwx    1 0        0                7 Apr 12 01:28 cttyhack -> busybox
....
# All the commands in the /bin directory are symbolic links to the BusyBox binary. This means that a single executable (busybox) provides multiple utilities such as ls, rm, sh, and vi. This design reduces storage usage and is ideal for minimal or embedded systems. This demonstrates how BusyBox simplifies system design by combining many tools into a single binary, making it efficient for lightweight environments. 

# 4
echo "hola" > test.txt
stat test.txt 
# Results 
  File: test.txt
  Size: 5               Blocks: 8          IO Block: 4096   regular file
Device: 0,45    Inode: 714973      Links: 1
Access: (0644/-rw-r--r--)  Uid: (    0/    root)   Gid: (    0/    root)
Access: 2026-04-12 19:18:11.789634350 +0000
Modify: 2026-04-12 19:18:11.789634350 +0000
Change: 2026-04-12 19:18:11.789634350 +0000
 Birth: 2026-04-12 19:18:11.789634350 +0000
# The file test.txt created with the content “hola” has a real size of 5 bytes, but when checking with stat, it shows that it occupies 8 blocks with an I/O block size of 4096 bytes. This means the filesystem allocates full blocks even for very small files. As a result, most of the allocated space inside those blocks is not used. Therefore, there is internal fragmentation because the disk space used is much larger than the actual file size.

# 5
sudo parted -l && echo -e "\n---\n" && lsblk -f
# Results
Model: Msft Virtual Disk (scsi)
Disk /dev/sda: 32.2GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End     Size    File system  Name  Flags
14      1049kB  5243kB  4194kB                     bios_grub
15      5243kB  116MB   111MB   fat32              boot, esp
 1      116MB   32.2GB  32.1GB  ext4


Model: Msft Virtual Disk (scsi)
Disk /dev/sdb: 48.3GB
Sector size (logical/physical): 512B/4096B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
 1      1049kB  48.3GB  48.3GB  primary  ext4


Model: Msft Virtual Disk (scsi)
Disk /dev/sdc: 550GB
Sector size (logical/physical): 512B/4096B
Partition Table: gpt
Disk Flags: 

Number  Start   End    Size   File system  Name      Flags
 1      1049kB  550GB  550GB  ext4         ext4part



---

NAME    FSTYPE FSVER LABEL UUID FSAVAIL FSUSE% MOUNTPOINTS
loop0                                          
loop1                                          
loop2                                          
loop3                                          
loop4                             13.6G    52% /workspaces/.codespaces/.persistedshare
                                               /var/lib/docker
                                               /home/vscode/.minikube
                                               /etc/hosts
                                               /etc/hostname
                                               /etc/resolv.conf
                                               /workspaces
loop5                                          
sda                                            
├─sda1                            11.4G    61% /workspaces/.codespaces/shared
│                                              /.codespaces/bin
│                                              /vscode
│                                              /usr/sbin/docker-init
├─sda14                                        
└─sda15                                        
sdb                                            
└─sdb1                            39.5G     5% /tmp
sdc                                            
└─sdc1                                         
sr0                      
# The system contains three disks: /dev/sda, /dev/sdb, and /dev/sdc. The disks /dev/sda and /dev/sdc use GPT (GUID Partition Table), while /dev/sdb uses MBR (msdos). Regarding filesystems, FAT32 is used for the EFI system partition on /dev/sda, and ext4 is used for Linux partitions on /dev/sda, /dev/sdb, and /dev/sdc. Therefore, the system combines both partition schemes (GPT and MBR) and mainly uses FAT32 and ext4 filesystems, demonstrating how storage is organized at a low level.
