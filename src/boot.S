.section ".text.boot" //for the linker 
.global _start //make global

_start:
    // Check processor ID is zero (executing on main core), else hang
    mrs     x1, mpidr_el1 //this maps the processor ID into the x1
    and     x1, x1, #3
    cbz     x1, 2f
    
    // We're not on the main core, so hang in an infinite wait loop
    // Cores 1-3 will spin here
1:  wfe
    b       1b
    
2:  // We're on the main core (core 0)!
    
    // Set stack pointer
    ldr     x1, =__stack_top    // __stack_top is defined in linker script as 0x80000
    mov     sp, x1
    
    // Zero out BSS section
    ldr     x1, =__bss_start
    ldr     x2, =__bss_end
3:  cmp     x1, x2
    b.ge    4f
    str     xzr, [x1], #8       // this is kinda like a while loop checking the address                             //values agains eachother
    b       3b



/*
4:  // Check current exception level
    mrs x0, CurrentEL
    and x0, x0, #12
    
    // Check if we're in EL2
    cmp x0, #8
    bne 5f  // Changed from 1f to avoid label conflict
    
    // Configure and drop to EL1
    ldr x1, =vector_table_el2
    msr VBAR_EL2, x1
    
    // Enable AArch64 in EL1
    mov x2, #(1 << 31)
    msr HCR_EL2, x2
    
    // Set EL1 entry point
    adr x2, 5f
    msr ELR_EL2, x2
    eret

5:  // Now in EL1
    ldr x1, =vector_table_el1
    msr VBAR_EL1, x1
    bl main
    */ 
    // If main returns, hang (infinite loop)
6:  b 6b