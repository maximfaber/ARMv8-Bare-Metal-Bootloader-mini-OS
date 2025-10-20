# ARMv8-Bare-Metal-Bootloader-mini-OS
Lightweight bare metal bootloader and OS for a ras PI4.
This project is still in progress and will be continuosly updated for the forseeable future.
current qemu flag on : QEMU emulator version 10.1.0
Copyright (c) 2003-2025 Fabrice Bellard and the QEMU Project developers
is qemu-system-aarch64 -M raspi4b -m 2G -kernel kernel8.img -serial mon:stdio -nographic -s -S 
this is not final and constatly changes depending on what is being assesed 
the -s -S is for gdb integration on port 1234 (very usefull)
