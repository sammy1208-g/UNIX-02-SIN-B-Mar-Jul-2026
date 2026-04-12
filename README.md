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