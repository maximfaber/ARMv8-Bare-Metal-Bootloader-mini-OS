/*all this part does is set up the sections the location counter " . "
marks the top of the allocation for the current section
*/

SECTIONS  
{
    . = 0x80000;     /* Kernel load address for AArch64 */
   
    /* Boot code comes first */
    .text.boot : { 
        KEEP(*(.text.boot)) 
    }
        /*
    the .text.boot means starting at . include the obj file with the text.boot (specifier???) and 
    allocate that much space 
    */
    
    /* Align for exception vector tables (2KB boundary) */
    . = ALIGN(0x800);
    .vectors : {
        KEEP(*(.vectors))
    }
    
    /* Regular code sections */
    .text : { 
        *(.text .text.* .gnu.linkonce.t*) 
    }
    
    .rodata : { 
        *(.rodata .rodata.* .gnu.linkonce.r*) 
    }
    
    /* Data sections */
    . = ALIGN(0x8);
    PROVIDE(_data = .);
    .data : { 
        *(.data .data.* .gnu.linkonce.d*) 
    } //provide allows _data to be definded in the c .text kernel script(s) and not break everything
    
    /* BSS section (uninitialized data) */
    .bss (NOLOAD) : {
        . = ALIGN(16);
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    }
    
    /* End of kernel */
    . = ALIGN(0x8);
    _end = .;
    
    /* Stack starts at 0x80000 and grows down */
    /* This symbol defines where the stack top should be */
    __stack_top = 0x80000;
    
    /* Calculate BSS size in 8-byte chunks for clearing loop */
    __bss_size = (__bss_end - __bss_start) >> 3;
    
    /* Remove debug sections and other unnecessary data */
    /DISCARD/ : { 
        *(.comment) 
        *(.gnu*) 
        *(.note*) 
        *(.eh_frame*) 
    }
}
