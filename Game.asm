[org 0x0100]

jmp start

;********* variables **********

offset: dw 3920
box: dw 0x07dc
oldkb: dd 0
oldtimer: dd 0
line1: db 'START !', 0
line2: db 'SCORE: ', 0
line3: db 'MISSED: ', 0
line4: db 'GAME OVER', 0
life: dw 0
score: dw 0
rand: dw 0
randnum: dw 0
char1: dw 0
char1offset: dw 0
char1print: dw 0
char1time: dw 0
char2: dw 0
char2offset: dw 0
char2print: dw 0
char2time: dw 0
char3: dw 0
char3offset: dw 0
char3print: dw 0
char3time: dw 0
char4: dw 0
char4offset: dw 0
char4print: dw 0
char4time: dw 0
char5: dw 0
char5offset: dw 0
char5print: dw 0
char5time: dw 0
ordercheck: dw 0;
; ***************************************Declaring Variables************************************* 
Press: db ' Press Enter To Continue :', 0
StartScreen :db ' START', 0
GameName: db 'Developer: Haris & Moeez', 0 
Developers : db 'WORD CATCHER GAME',0
RecordLine: db 'GAME RECORDS',0
ExitLines: db'EXIT',0
Pointer: db'=>',0
GameRecord: dw 0,0,0,0,0,0;
Index: dw 0;
exiter : db 'Press ESC to exit',0
recordhistory : db 'RECORD HISTORY',0

;  ****************************************Subroutine Area****************************************
; *****subroutine to clear the screen ******
clrscr: 
 push es 
 push ax 
 push cx 
 push di 
 mov ax, 0xb800 
 mov es, ax 
 xor di, di 
 mov ax, 0xe720 
 mov cx, 2000 
 cld  
 rep stosw  
 pop di
 pop cx 
 pop ax 
 pop es 
 ret 
 
 ;*****String Length *****
 strlen: 
 push bp 
 mov bp,sp 
 push es 
 push cx 
 push di 
 les di, [bp+4] ; point es:di to string 
 mov cx, 0xffff ; load maximum number in cx 
 xor al, al ; load a zero in al 
 repne scasb ; find zero in the string 
 mov ax, 0xffff ; load maximum number in ax 
 sub ax, cx ; find change in cx 
 dec ax ; exclude null from length 
 pop di 
 pop cx 
 pop es 
 pop bp 
 ret 4 
; subroutine to print a string 
; takes the x position, y position, attribute, and address of a null 
; terminated string as parameters 
printstr: 
printstr: 
 push bp 
 mov bp, sp 
 push es 
 push ax 
 push cx 
 push si 
 push di 
 push ds ; push segment of string 
 mov ax, [bp+4] 
 push ax ; push offset of string 
 call strlen
 cmp ax, 0 ; is the string empty 
 jz exiting ; no printing if string is empty
 mov cx, ax ; save length in cx 
 mov ax, 0xb800 
 mov es, ax ; point es to video base 
 mov al, 80 ; load al with columns per row 
 mul byte [bp+10] ; multiply with y position 
 add ax, [bp+8] ; add x position 
 shl ax, 1 ; turn into byte offset 
 mov di,ax ; point di to required location 
 mov si, [bp+4] ; point si to string 
 mov ah, [bp+6] ; load attribute in ah 
 cld ; auto increment mode 
nextchar: 
lodsb ; load next char in al 
 stosw ; print char/attribute pair 
 loop nextchar ; repeat for the whole string 
exiting: pop di 
 pop si 
 pop cx 
 pop ax 
 pop es 
 pop bp 
 ret 8

;*****HomePage***** 
StartPage:
  call clrscr ; call clrscr subroutine
; *****Start option***** 
 mov ax, 7
 push ax ; push x position 
 mov ax,  36
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, StartScreen 
 push ax ; push address of message 
 call printstr 
 
 ;*****Press to enter*****
 mov ax, 20
 push ax ; push x position 
 mov ax, 0
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, Press 
 push ax ; push address of message 
 call printstr 
 
 ;*****Devaloper Name*****
 mov ax, 3
 push ax ; push x position 
 mov ax, 29
 push ax ; push y position 
 mov ax, 0x60 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, GameName 
 push ax ; push address of message 
 call printstr 
 
 ;******Game Name*****
 mov ax, 0
 push ax ; push x position 
 mov ax, 32
 push ax ; push y position 
 mov ax, 0x60 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, Developers 
 push ax ; push address of message 
 call printstr
 
  ;******Game Records*****
 mov ax, 10
 push ax ; push x position 
 mov ax, 33
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, RecordLine 
 push ax ; push address of message 
 call printstr
 
   ;******Exit*****
 mov ax, 13
 push ax ; push x position 
 mov ax, 37
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, ExitLines 
 push ax ; push address of message 
 call printstr
 mov ax,7
 
ret 

PrintPointer:

 mov [ordercheck],ax;
 push ax ; push x position 
 mov ax, 30
 push ax ; push y position 
 call StartPage;
 mov ax, 0x6c ; blue on white attribute 
 push ax ; push attribute 
 mov ax, Pointer 
 push ax ; push address of message 
 call printstr
 
ret;

;**********delay
delay:
push dx
    mov dx, 0FFFFh    
delay_loop:
    nop               
    dec dx            
    jnz delay_loop 	
	pop dx
    ret 
;************************************************************above modified
;******** printing lines ********

endingline:
push ax
push si
push di
push bx
push cx
mov ax, 0xb800
mov es, ax
mov di, 1832
mov cx, 9
mov ah, 0x84
mov si, line4
cld
e1:
lodsb
stosw
loop e1
mov di, 1980
mov cx, 7
mov ah, 0x67
mov si, line2
cld
pp2:
lodsb
stosw
loop pp2
mov di, 2002
mov cx, 8
mov ah, 0x67
mov si, line3
cld
ppp2:
lodsb
stosw
loop ppp2
mov ax, 1994
push ax
push word[score]
call printnum
mov ax, 2018
push ax
push word[life]
call printnum
pop cx
pop bx
pop di
pop si
pop ax
ret

missedline:
push ax
push si
push di
push bx
push cx
mov ax, 0xb800
mov es, ax
mov di, 20
mov cx, 8
mov ah, 0x61
mov si, line3
cld
p3:
lodsb
stosw
loop p3
pop cx
pop bx
pop di
pop si
pop ax
ret

scoreline:
push ax
push si
push di
push bx
push cx
mov ax, 0xb800
mov es, ax
mov di, 114
mov cx, 7
mov ah, 0x6E
mov si, line2
cld
p2:
lodsb
stosw
loop p2
pop cx
pop bx
pop di
pop si
pop ax
ret

;********* keyboard isr *********

kbisr:

push ax
in al, 0x60
cmp al, 0x4b
jne nextcmp
call clearll
call decbox
call printbox
jmp exit
nextcmp:
cmp al, 0x4d
jne nomatch
call clearll
call incbox
call printbox
jmp exit
nomatch:
pop ax
jmp far [cs:oldkb]
kbreturn:

exit: 
mov al, 0x20
out 0x20, al
pop ax
iret

;********** box movement and printing *********

printbox:
push ax
mov ax, 0xB800
mov es, ax 
mov di, word[offset]
mov ax, word[box]
mov ah,0x6f
mov word[es:di], ax
pop ax
ret

decbox:
cmp word[offset], 3840
jbe bie
push ax
mov ax, word[offset]
sub ax, 2
mov word[offset], ax
pop ax
jmp biebie
bie:
push ax
mov ax, 3998
mov word[offset], ax
pop ax
biebie:
ret

incbox:
cmp word[offset], 3998
jae bie2
push ax
mov ax, word[offset]
add ax, 2
mov word[offset], ax
pop ax
jmp biebie2
bie2:
push ax
mov ax, 3840
mov word[offset], ax
pop ax
biebie2:
ret

;********** clear functions **********

clear:
push ax
mov ax, 0xB800
mov es, ax
mov di, 0
hello:
mov word[es:di], 0x6720
add di, 2
cmp di, 4000
jne hello
pop ax
ret

clearll:
push ax
mov ax, 0xB800
mov es, ax
mov di, 3840
hello1:
mov word[es:di], 0x6720
add di, 2
cmp di, 4000
jne hello1
pop ax
ret

;********* prints score and life *********



printnum:
push bp
mov bp, sp
push es
push ax
push bx
push cx
push dx
push di
mov ax, 0xb800
mov es, ax ; point es to video base
mov ax, [bp+4] ; load number in ax
mov bx, 10 ; use base 10 for division
mov cx, 0 ; initialize count of digits
nextdigitt: 
mov dx, 0 ; zero upper half of dividend
div bx ; divide by 10
add dl, 0x30 ; convert digit into ascii value
push dx ; save ascii value on stack
inc cx ; increment count of values
cmp ax, 0 ; is the quotient zero
jnz nextdigitt ; if no divide it again
mov di, [bp+6] ; point di to 70th column
nextposs: pop dx ; remove a digit from the stack
mov dh, 0x67 ; use normal attribute
mov [es:di], dx ; print char on screen
add di, 2 ; move to next screen location
loop nextposs ; repeat for all digits on stack
pop di
pop dx
pop cx
pop bx
pop ax
pop es
pop bp
ret 4

numberdisplay:
mov ax, 128
push ax
push word[score]
call printnum
mov ax, 36
push ax
push word[life]
call printnum
ret

;********* timer isr **********

timer:
call character1
call character2
call character3
call character4
call character5
jmp far [cs:oldtimer]

;********** character functions ************

character1:
call numberdisplay
inc word [char1time]
cmp word [char1time], 7
jne midend
mov word [char1time], 0
cmp word [char1print], 0
jne movdown1
mov word[rand], 0
mov word[randnum], 0
call randomsetter
mov ax, 0xb800
mov es, ax
mov di, [char1offset]
mov ax, [char1]
mov word[es:di], ax
inc word [char1print]
jmp end
movdown1:
mov di, [char1offset]
mov word[es:di], 0x6720
add word [char1offset], 160
cmp word [char1offset], 3840
ja changechar1
mov di, [char1offset]
mov ax, [char1]
mov word[es:di], ax
midend:
jmp end
changechar1:
push ax
mov ax, [char1offset]
cmp ax, [offset]
jne inclife
pop ax
inc word [score]
mov word [char1offset], 0
mov word [char1], 0
mov word [char1print], 0
jmp end
inclife:
pop ax
inc word [life]
mov word [char1offset], 0
mov word [char1], 0
mov word [char1print], 0
end:
ret


character2:
call numberdisplay
inc word [char2time]
cmp word [char2time], 3
jne midend2
mov word [char2time], 0
cmp word [char2print], 0
jne movdown2
mov word[rand], 0
mov word[randnum], 0
call randomsetter2
mov ax, 0xb800
mov es, ax
mov di, [char2offset]
mov ax, [char2]
mov word[es:di], ax
inc word [char2print]
jmp end2
movdown2:
mov di, [char2offset]
mov word[es:di], 0xe720
add word [char2offset], 160
cmp word [char2offset], 3840
ja changechar2
mov di, [char2offset]
mov ax, [char2]
mov word[es:di], ax
midend2:
jmp end2
changechar2:
push ax
mov ax, [char2offset]
cmp ax, [offset]
jne inclife2
pop ax
inc word [score]
mov word [char2offset], 0
mov word [char2], 0
mov word [char2print], 0
jmp end
inclife2:
pop ax
inc word [life]
mov word [char2offset], 0
mov word [char2], 0
mov word [char2print], 0
end2:
ret


character3:
call numberdisplay
inc word [char3time]
cmp word [char3time], 15
jne midend3
mov word [char3time], 0
cmp word [char3print], 0
jne movdown3
mov word[rand], 0
mov word[randnum], 0
call randomsetter3
mov ax, 0xb800
mov es, ax
mov di, [char3offset]
mov ax, [char3]
mov word[es:di], ax
inc word [char3print]
jmp end3
movdown3:
mov di, [char3offset]
mov word[es:di], 0xe720
add word [char3offset], 160
cmp word [char3offset], 3840
ja changechar3
mov di, [char3offset]
mov ax, [char3]
mov word[es:di], ax
midend3:
jmp end
changechar3:
push ax
mov ax, [char3offset]
cmp ax, [offset]
jne inclife3
pop ax
inc word [score]
mov word [char3offset], 0
mov word [char3], 0
mov word [char3print], 0
jmp end3
inclife3:
pop ax
inc word [life]
mov word [char3offset], 0
mov word [char3], 0
mov word [char3print], 0
end3:
ret

character4:
call numberdisplay
inc word [char4time]
cmp word [char4time], 11
jne midend4
mov word [char4time], 0
cmp word [char4print], 0
jne movdown4
mov word[rand], 0
mov word[randnum], 0
call randomsetter4
mov ax, 0xb800
mov es, ax
mov di, [char4offset]
mov ax, [char4]
mov word[es:di], ax
inc word [char4print]
jmp end4
movdown4:
mov di, [char4offset]
mov word[es:di], 0xe720
add word [char4offset], 160
cmp word [char4offset], 3840
ja changechar4
mov di, [char4offset]
mov ax, [char4]
mov word[es:di], ax
midend4:
jmp end4
changechar4:
push ax
mov ax, [char4offset]
cmp ax, [offset]
jne inclife4
pop ax
inc word [score]
mov word [char4offset], 0
mov word [char4], 0
mov word [char4print], 0
jmp end4
inclife4:
pop ax
inc word [life]
mov word [char4offset], 0
mov word [char4], 0
mov word [char4print], 0
end4:
ret


character5:
call numberdisplay
inc word [char5time]
cmp word [char5time], 18
jne midend5
mov word [char5time], 0
cmp word [char5print], 0
jne movdown5
mov word[rand], 0
mov word[randnum], 0
call randomsetter5
mov ax, 0xb800
mov es, ax
mov di, [char5offset]
mov ax, [char5]
mov word[es:di], ax
inc word [char5print]
jmp end5
movdown5:
mov di, [char5offset]
mov word[es:di], 0xe720
add word [char5offset], 160
cmp word [char5offset], 3840
ja changechar5
mov di, [char5offset]
mov ax, [char5]
mov word[es:di], ax
midend5:
jmp end
changechar5:
push ax
mov ax, [char5offset]
cmp ax, [offset]
jne inclife5
pop ax
inc word [score]
mov word [char5offset], 0
mov word [char5], 0
mov word [char5print], 0
jmp end5
inclife5:
pop ax
inc word [life]
mov word [char5offset], 0
mov word [char5], 0
mov word [char5print], 0
end5:
ret

;********* random chararcter and number ********

randG:
mov word [rand],0
mov word [randnum],0
push bp
mov bp, sp
pusha
cmp word [rand], 0
jne next
MOV AH, 00h 
INT 1AH
inc word [rand]
mov [randnum], dx
jmp next1
next:
mov ax, 25173
mul word  [randnum]
add ax, 13849
mov [randnum], ax
next1:xor dx, dx
mov ax, [randnum]
mov cx, [bp+4]
inc cx
div cx
add dl,'A'
mov [bp+6], dx
popa
pop bp
ret 2

randGnum:
mov word [rand],0
mov word [randnum],0
push bp
mov bp, sp
pusha
cmp word [rand], 0
jne nextt
MOV AH, 00h 
INT 1AH
inc word [rand]
mov [randnum], dx
jmp next2
nextt:
mov ax, 25173         
mul word  [randnum]   
add ax, 13849     
mov [randnum], ax
next2:xor dx, dx
mov ax, [randnum]
mov cx, [bp+4]
inc cx
div cx
mov [bp+6], dx
popa
pop bp
ret 2

randomsetter:
push ax
sub sp, 2
push 25
call randG
pop ax
mov ah, 0x6E
mov word[char1], ax
mov ax, 0
sub sp, 2
push 80
call randGnum
pop ax
shl ax, 1
add ax, 54
cmp ax, 160
jae mover1
add ax, 160
mover1:
mov word[char1offset], ax
pop ax
ret


randomsetter2:
push ax
sub sp, 2
push 25
call randG
pop ax
mov ah, 0x6C
mov word[char2], ax
mov ax, 0
sub sp, 2
push 80
call randGnum
pop ax
shl ax, 1
add ax, 128
cmp ax, 160
jae mover2
add ax, 160
mover2:
mov word[char2offset], ax
pop ax
ret

randomsetter3:
push ax
sub sp, 2
push 25
call randG
pop ax
mov ah, 0x6D
mov word[char3], ax
mov ax, 0
sub sp, 2
push 80
call randGnum
pop ax
shl ax, 1
add ax, 104
cmp ax, 160
jae mover3
add ax, 160
mover3:
mov word[char3offset], ax
pop ax
ret

randomsetter4:
push ax
sub sp, 2
push 25
call randG
pop ax
mov ah, 0x69
mov word[char4], ax
mov ax, 0
sub sp, 2
push 80
call randGnum
pop ax
shl ax, 1
add ax, 74
cmp ax, 160
jae mover4
add ax, 160
mover4:
mov word[char4offset], ax
pop ax
ret

randomsetter5:
push ax
sub sp, 2
push 25
call randG
pop ax
mov ah, 0x6A
mov word[char5], ax
mov ax, 0
sub sp, 2
push 80
call randGnum
pop ax
shl ax, 1
add ax, 36
cmp ax, 160
jae mover5
add ax, 160
mover5:
mov word[char5offset], ax
pop ax
ret

ResetVariables:

mov Word[life], 0
mov Word[score], 0
mov Word[rand], 0
mov Word[randnum], 0
mov Word[char1], 0
mov Word[char1offset], 0
mov Word[char1print], 0
mov Word[char1time], 0
mov Word[char2], 0
mov Word[char2offset], 0
mov Word[char2print], 0
mov Word[char2time], 0
mov Word[char3], 0
mov Word[char3offset], 0
mov Word[char3print], 0
mov Word[char3time], 0
mov Word[char4], 0
mov Word[char4offset], 0
mov Word[char4print], 0
mov Word[char4time], 0
mov Word[char5], 0
mov Word[char5offset], 0
mov Word[char5print], 0
mov Word[char5time], 0

ret;
	
	
;*************recordlist************
recordlist:
call clrscr
push bp
mov bp,sp
push si 
push ax
push cx
push bx
push di

 mov ax, 3
 push ax ; push x position 
 mov ax, 33
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, recordhistory 
 push ax ; push address of message 
 call printstr
 

mov cx,12
mov si,0
mov bx,GameRecord
mov di ,1040
hahaloop:
push di
mov ax,[bx+si]
push ax
call printnum
add si,2
add di,160
cmp cx,si
jne hahaloop
 
 mov ax, 20
 push ax ; push x position 
 mov ax, 0
 push ax ; push y position 
 mov ax, 0x67 ; blue on white attribute 
 push ax ; push attribute 
 mov ax, exiter 
 push ax ; push address of message 
 call printstr
 
 
mov ah,0
int 16h
cmp al,1bh

pop di
pop bx
pop cx
pop ax
pop si
pop bp
ret	
	
;********** start *************

start:

 pusha;
 
start_ing:
 
 call StartPage

l2:

 call PrintPointer;
 mov ah,0
 int 16h
 cmp al,0dh;
 je check;
 cmp ah,0x48; up
 je up;
 cmp ah,0x50; down
 je down;
 
 jmp start_ing;
 
up:
 cmp word[ordercheck],7;
 je start_ing;
 mov ax,[ordercheck];
 sub ax,3;
 jmp l2;
 
down:
 cmp word[ordercheck],13;
 je start_ing;
 mov ax,[ordercheck];
 add ax,3;
 jmp l2;
 
check:

cmp word[ordercheck],7;
je gamestarting;
cmp word[ordercheck],10;
je showrecords; ????

jmp termination;

gamestarting:


call clear
call scoreline
call missedline
call printbox

xor ax, ax
mov es, ax ; point es to IVT base
mov ax, [es:9*4]
mov word[oldkb], ax
mov ax, [es:9*4+2]
mov word[oldkb+2], ax
mov ax, [es:8*4]
mov word[oldtimer], ax
mov ax, [es:8*4+2]
mov word[oldtimer+2], ax
cli
mov word [es:9*4], kbisr
mov [es:9*4+2], cs
mov word [es:8*4], timer
mov [es:8*4+2], cs
sti

label:
cmp word[life], 10
jae finalexit
jmp label

finalexit:

cli
xor ax, ax
mov es, ax
mov cx, [oldtimer]
mov dx, [oldtimer+2]
mov word [es:8*4], cx
mov word [es:8*4+2], dx

mov cx, [oldkb]
mov dx, [oldkb+2]
mov word [es:9*4], cx
mov word [es:9*4+2], dx

sti
call clear
mov word[life], 10
call endingline
mov dx, start
add dx,15
mov cl, 4
shr dx, cl

popa;

mov ah,0;
int 16h;
cmp al,1bh;
je termination;

mov ax,[score];
mov bx,[Index];
mov [GameRecord+bx],ax;
add bx,2;
mov [Index],bx;

call ResetVariables;
jmp here

showrecords:

call recordlist

here:
jmp start;



termination:

mov ax, 0x3100
int 21h