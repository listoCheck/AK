.data
input_addr:  .word 0x80
output_addr: .word 0x84

.text

_start:
    @p input_addr b! @b
    dup
    inv
    -if write_neg
    lit 0             
    over              

count_ones:
    dup
    if finish
    over
    a!
    dup
    lit 0x1
    and
    a
    +
    over
    2/
    count_ones

write_neg:
    inv
    lit 0             
    over

neg_while:
    dup
    if neg_finish
    over
    a!
    dup
    lit 0x1
    and
    a
    +
    over
    2/
    neg_while
    

finish:
    over
    @p output_addr a!
    !
    halt

neg_finish:
    over
    inv
    lit 33
    +
    @p output_addr a!
    !
    halt
