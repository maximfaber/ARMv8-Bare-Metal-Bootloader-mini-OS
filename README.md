# ARMv8 Bare Metal Bootloader & Mini OS

Lightweight bare metal bootloader and OS for a Raspberry Pi 4b.

> **Project Status**:  
> This project is still in progress and will be continuously updated for the foreseeable future.
> currently working on uart drivers/implimentation and testing.

---

## QEMU Configuration

Current QEMU version used:  
```bash
qemu-system-aarch64 \
  -M raspi4b \
  -m 2G \
  -kernel kernel8.img \
  -serial mon:stdio \
  -nographic \
  -s -S
