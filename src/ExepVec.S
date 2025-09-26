/*
.section ".vectors", "ax"

// Macro to create a minimal exception handler stub
.macro vector_entry handler_name
    .align 7 // Each entry must be 128-byte aligned
    stp x29, x30, [sp, #-16]!
    bl \handler_name
    ldp x29, x30, [sp], #16
    eret
.endm

// EL1 Exception Vector Table
.align 11 // Align to 2048 bytes (2^11)
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
    // Current EL with SP0
    vector_entry el2_sp0_sync_handler
    vector_entry el2_sp0_irq_handler
    vector_entry el2_sp0_fiq_handler
    vector_entry el2_sp0_error_handler
    
    // Current EL with SPx
    vector_entry el2_spx_sync_handler
    vector_entry el2_spx_irq_handler
    vector_entry el2_spx_fiq_handler
    vector_entry el2_spx_error_handler
    
    // Lower EL using AArch64
    vector_entry el2_aarch64_sync_handler
    vector_entry el2_aarch64_irq_handler
    vector_entry el2_aarch64_fiq_handler
    vector_entry el2_aarch64_error_handler
    
    // Lower EL using AArch32
    vector_entry el2_aarch32_sync_handler
    vector_entry el2_aarch32_irq_handler
    vector_entry el2_aarch32_fiq_handler
    vector_entry el2_aarch32_error_handler

// Make vector tables globally visible
.global vector_table_el1
.global vector_table_el2
*/