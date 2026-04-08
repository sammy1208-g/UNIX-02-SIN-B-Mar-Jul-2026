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

ls arch/x86/boot/bzImage
sudo mkdir /boot-files
sudo cp arch/x86/boot/bzImage /boot-files/
cd ..
git clone --depth 1 https://git.busybox.net/busybox
cd busybox
make menuconfig
make -j 2
sudo mkdir /boot-files/initramfs
sudo make CONFIG_PREFIX=/boot-files/initramfs install
