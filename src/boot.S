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
    str     xzr, [x1], #8       // this is kinda like a while loop checking the address
                                    //values agains eachother
    b       3b

4:  // Check current exception level
    mrs     x0, CurrentEL
    and     x0, x0, #12         // Clear reserved bits
    
    // Check if we're in EL3
    cmp     x0, #12
    bne     5f
    
    // If in EL3, configure and drop to EL2
    ldr     x1, =vector_table_el3
    msr     VBAR_EL3, x1
    
    // Configure EL3 to run EL2 in AArch64 mode even tho we should not boot into el3 its more of a safety thing
    mov     x2, #0x5b1          
    msr     SCR_EL3, x2 
        
    // Set EL2 entry point
    adr     x2, 5f
    msr     ELR_EL3, x2
    eret                        // Drop to EL2
    
5:  // Check if we're in EL2
    mrs     x0, CurrentEL
    and     x0, x0, #12
    cmp     x0, #8
    bne     6f
    
    // If in EL2, configure and drop to EL1
    ldr     x1, =vector_table_el2
    msr     VBAR_EL2, x1
    
    // Enable AArch64 in EL1
    mov     x2, #(1 << 31)      // HCR_EL2.RW = 1 (AArch64)
    msr     HCR_EL2, x2

    // Set EL1 entry point
    adr     x2, 6f
    msr     ELR_EL2, x2
    eret                        // Drop to EL1

6:  // Now in EL1 (or started in EL1)
    // Set up exception vectors for EL1
    ldr     x1, =vector_table_el1
    msr     VBAR_EL1, x1
    
    // Jump to C code
    bl      main
    
    // If main returns (it shouldn't), hang
    b       1b


.section ".vectors", "ax"
.align 11   // Align to 2048 bytes (2^11)

// Macro to create a minimal exception handler stub
.macro vector_entry handler_name
    .align 7                    // Each entry must be 128-byte aligned
    stp     x29, x30, [sp, #-16]!
    bl      \handler_name
    ldp     x29, x30, [sp], #16
    eret
.endm

// EL1 Exception Vector Table
vector_table_el1:

    // Current EL with SP0
    vector_entry el1_sp0_sync_handler
    vector_entry el1_sp0_irq_handler
    vector_entry el1_sp0_fiq_handler
    vector_entry el1_sp0_error_handler
    
    // Current EL with SPx
    vector_entry el1_spx_sync_handler
    vector_entry el1_spx_irq_handler
    vector_entry el1_spx_fiq_handler
    vector_entry el1_spx_error_handler
    
    // Lower EL using AArch64
    vector_entry el1_aarch64_sync_handler
    vector_entry el1_aarch64_irq_handler
    vector_entry el1_aarch64_fiq_handler
    vector_entry el1_aarch64_error_handler
    
    // Lower EL using AArch32
    vector_entry el1_aarch32_sync_handler
    vector_entry el1_aarch32_irq_handler
    vector_entry el1_aarch32_fiq_handler
    vector_entry el1_aarch32_error_handler

// EL2 Exception Vector Table
.align 11
vector_table_el2:
    vector_entry el2_sp0_sync_handler
    vector_entry el2_sp0_irq_handler
    vector_entry el2_sp0_fiq_handler
    vector_entry el2_sp0_error_handler
    
    vector_entry el2_spx_sync_handler
    vector_entry el2_spx_irq_handler
    vector_entry el2_spx_fiq_handler
    vector_entry el2_spx_error_handler
    
    vector_entry el2_aarch64_sync_handler
    vector_entry el2_aarch64_irq_handler
    vector_entry el2_aarch64_fiq_handler
    vector_entry el2_aarch64_error_handler
    
    vector_entry el2_aarch32_sync_handler
    vector_entry el2_aarch32_irq_handler
    vector_entry el2_aarch32_fiq_handler
    vector_entry el2_aarch32_error_handler

// EL3 Exception Vector Table
.align 11
vector_table_el3:
    vector_entry el3_sp0_sync_handler
    vector_entry el3_sp0_irq_handler
    vector_entry el3_sp0_fiq_handler
    vector_entry el3_sp0_error_handler
    
    vector_entry el3_spx_sync_handler
    vector_entry el3_spx_irq_handler
    vector_entry el3_spx_fiq_handler
    vector_entry el3_spx_error_handler
    
    vector_entry el3_aarch64_sync_handler
    vector_entry el3_aarch64_irq_handler
    vector_entry el3_aarch64_fiq_handler
    vector_entry el3_aarch64_error_handler
    
    vector_entry el3_aarch32_sync_handler
    vector_entry el3_aarch32_irq_handler
    vector_entry el3_aarch32_fiq_handler
    vector_entry el3_aarch32_error_handler
