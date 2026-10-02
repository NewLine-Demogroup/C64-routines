* = $0801
BasicUpstart2(start)


* = $080d
start:
    sei
    //lda #$00
    //jsr sid1.init

    //lda #147
    //sta $ffd2
    //jsr text

    lda #$0f
    sta $d418
    //sta $d518

    lda #$7f
    sta $dc0d
    sta $dd0d

    lda #<samplestart
    sta $fb
    lda #>samplestart
    sta $fc

    //lda #$0f
    //sta $d405
    //lda #$ff
    //sta $d406
    //sta $d506
    //lda #$0f
    //sta $d40c
    //lda #$ff
    //sta $d40d
    //sta $d50d
    lda #$0f
    sta $d413
    lda #$ff
    sta $d414
    //sta $d514
    lda #$00
    sta $d410
    lda #$00
    sta $d400
    sta $d407
    sta $d40e
    lda #$09
    sta $d404
    sta $d40b
    sta $d412
    lda #$ff
    sta $d415
    sta $d416
    lda #$03
    sta $d417

    lda #<((985248/11025))
    sta $dd04
    lda #>((985248/11025))
    sta $dd05
    lda #$81
    sta $dd0d  

    lda #<irq
    sta $0318
    lda #>irq
    sta $0319

    lda #$01
    sta $dd0e

    cli
    jmp *

text:
    ldx #$00
text_loop:
    lda texttext,x
    beq done
    sta $0400,x
    inx
    bne text_loop 

done:
    rts

irq:
    ldy #$00
    lda $dd0d

    lda #$00
    sta $d011

    pha
    txa
    pha
    tya
    pha 

    lda ($fb),y
    //eor #$80
    //beq reset
    //lsr
    //lsr
    //lsr
    //lsr
    //tay
    //lda table,y

    //clc
    //sbc #$05
    //sta $d401
    //sta $d408
    sta $d40f
    //sta $d408
    //sta $d50f
    //sta $d411
    //sta $d412
    //lsr
    //lsr
    //lsr
    //lsr
    //sta $d418
    //sta $d020
    //sta $df00
    //sta $df01

    //sta $de00
    //sta $de01


    lda #$11
    sta $d412
    //sta $d512

    lda #$09
    sta $d412
    //sta $d512

    lda #$01
    sta $d412
    //sta $d512

    iny
    inc $fb
    bne check_end
    inc $fc  

check_end:
    lda ($fb),y
    cmp sampleend
    bne exit
    lda ($fc),y
    cmp sampleend
    bne exit

    lda #<samplestart
    sta $fb
    lda #>samplestart
    sta $fc

exit:
    pla
    tax
    pla
    tay
    pla
    jmp irq

delay:
    ldx #$ff
delay_loop:
    dex
    bne delay_loop
    rts

shift_pitch_up:
    lda pitch
    clc
    adc #$01
    sta pitch
    jmp $ea81

shift_pitch_down:
    lda pitch
    clc
    sbc #$01
    sta pitch
    jmp $ea81   


texttext: .text "what you are hearing right now is a digisample playing on a custom digi player  by d/v / newline"
          .byte 0

ticks:  .byte 0
frame:  .byte 0

table:  .fill 256, i

pitch:  .byte 0

* = $1000
samplestart:
.import binary "sam.raw"
sampleend:

 