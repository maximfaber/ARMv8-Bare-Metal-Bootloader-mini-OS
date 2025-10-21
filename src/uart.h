#ifndef	MINI_UART_H
#define	MINI_UART_H

#define PBASE 0xFE000000
#define AUXBASE 0x7e215000 
#define AUX_ENABLES     (PBASE+ AUXBASE + 0x04)
#define AUX_MU_IO_REG   (PBASE+ AUXBASE + 0x40)
#define AUX_MU_IER_REG  (PBASE+ AUXBASE + 0x44)
#define AUX_MU_IIR_REG  (PBASE+ AUXBASE + 0x48)
#define AUX_MU_LCR_REG  (PBASE+ AUXBASE + 0x4c)
#define AUX_MU_MCR_REG  (PBASE+ AUXBASE + 0x50)
#define AUX_MU_LSR_REG  (PBASE+ AUXBASE + 0x54)
#define AUX_MU_MSR_REG  (PBASE+ AUXBASE + 0x58)
#define AUX_MU_SCRATCH  (PBASE+ AUXBASE + 0x5c)
#define AUX_MU_CNTL_REG (PBASE+ AUXBASE + 0x60)
#define AUX_MU_STAT_REG (PBASE+ AUXBASE + 0x64)
#define AUX_MU_BAUD_REG (PBASE+ AUXBASE + 0x68)
/*
The GPIO has the following registers. 
All accesses are assumed to be 32-bit. The GPIO register base address 
is 0x7e200000
*/
#define GPFSEL0  (PBASE + 0x200000)
#define GPFSEL1  (PBASE + 0x20001C)
#define GPFSEL2  (PBASE + 0x200028)
#define GPPUPPDN0  (PBASE + 0x2000E4)
// #define GPFSEL4  (PBASE + 0x200000)


#define AUX_MU_BAUD(baud) ((AUX_UART_CLOCK/(baud*8))-1)
#endif