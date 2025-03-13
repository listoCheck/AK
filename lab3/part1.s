.data
len:             .byte  1
buff:            .byte '______________________________________'
counter:         .word  1
zero:            .word  0
out_counter:     .word  1
input_addr:      .word  0x80
output_addr:     .word  0x84
perevod:         .word  0xA     ;\n
ns:              .word  0x61    ;a
sdd:             .word  0x7A    ;z
num:             .word  0x20    ;32
const_1:         .word  1
symbol:          .word  '_'
alert_out:       .word  858993460
five:            .word  0x0
ptr:             .word  0
x:               .word  0
const_FF:        .word  0xFF

.text

_start:
    load_ind input_addr
    sub perevod                     ; - 10
    beqz add_underlines             ; ливаем
    add perevod                     ; + 10

    sub ns                          ; - a
    bgt check_upper                 ; > a
    add ns                          ; + a
    jmp write

check_upper:
    add ns                          ; + a

    sub sdd                         ; - z
    bgt write                       ; > z
    add sdd                         ; + z
    sub num

write:
    store_ind counter
    
    load len
    add const_1
    store len

    load counter
    add const_1
    store counter

    sub num
    sub const_1
    beqz alert_end

    jmp _start

add_underlines:
    load zero
    add counter
    store zero

cycle:
    sub num
    sub const_1
    beqz end
    add num

    load_addr symbol
    store_ind counter
    load counter
    add const_1
    store counter
    jmp cycle


end:
    load_imm buff
    store ptr
    load         zero
    sub          const_1
    store        zero
while:
    beqz         real_end

    load_ind     ptr
    and          const_FF
    store_ind    output_addr

    load         ptr
    add          const_1
    store        ptr

    load         zero
    sub          const_1
    store        zero
    jmp          while    
    
alert_end:
    load zero
    sub alert_out
    store_ind output_addr

real_end:
    load len
    sub const_1
    store len
    halt

