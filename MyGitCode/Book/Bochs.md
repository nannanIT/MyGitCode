#  Bochs

brew install bochs

In order to prevent conflicts with Apple's own libtool we have prepended(前置) a "g"
so, you have instead: glibtool and glibtoolize.


bochsrc.txt-配置文件
```
# Configuration file for Bochs
###############################################
 
# 第一步，首先设置Bochs在运行过程中能够使用的内存，本例为32MB。
# 关键字为：megs
 
 
megs: 32
 
 
# 第二步，设置对应真实机器的BIOS和VGA BIOS.
# 对应两个关键字为：romimage 和 vgaromimage
 
romimage: file=/usr/local/share/bochs/BIOS-bochs-latest #Mac OSx 的特殊用户路径
vgaromimage: file=/usr/local/share/bochs/VGABIOS-lgpl-latest
 
 
# 第三步，设置Bochs所使用的磁盘，软盘的关键字为floppy。
# 若只有一个软盘，则使用floppya即可，若有多个，则为floppya，floppyb...
 
 
floppya: 1_44=boot.img , status=inserted
#floppya: type=1_44, image="boot.img", status=inserted
#镜像位置可以直接写镜像名称，前提是bochs在该目录运行
 
 
# 第四步，选择启动盘符。
 
 
boot: floppy
 
 
# 第五步，设置日志文件的输出。
 
 
log: bochsout.txt
 
 
# 第六步，开启或关闭某些功能。
# 下面是关闭鼠标，并打开键盘。
 
mouse: enabled=1
# keyboard:keymap=/usr/local/share/bochs/keymaps/sdl-pc-de.map #此处新版本语法变更
```

boot.asm
```
    org 07c00h ; 告诉编译器程序加载到 7c00处 
    mov ax, cs 
    mov ds, ax 
    mov es, ax                     
    call DispStr ; 调用显示字符串例程 
    jmp $ ; 无限循环 
DispStr: 
    mov ax, BootMessage 
    mov bp, ax ; es:bp = 串地址 
    mov cx, 16 ; cx = 串长度 
    mov ax, 01301h ; ah = 13, al = 01h 
    mov bx, 000ch ; 页号为 0(bh = 0) 黑底红字(bl = 0Ch,高亮) 
    mov dl, 0 
    int 10h ; 10h 号中断 
    ret 
BootMessage: 
    db "Hello, OS world!" 
    times 510-($-$$) db 0 ; 填充剩下的空间，使生成的二进制代码恰好为 
    dw 0xaa55 ; 结束标志
```
boot1.asm
```
    org 0x7c00
    jmp entry
    db 0x90
entry:
    mov ax,0
    mov ss,ax
    mov sp,0x7c00
    mov ds,ax
    mov es,ax
    mov si,msg
putloop:
    mov al,[si]
    add si,1
    cmp al,0
    je fin
    mov ah,0x0e
    mov bx,15
    int 0x10
    jmp putloop
fin:
    hlt
    jmp fin
    msg:
    db 0x0a,0x0a
    db "hello world!"
    db 0x0a
    db 0
    times 510 - ($-$$) db 0
    dw 0xaa55
```

nasm boot.asm -o boot.bin
dd if=boot.bin of=boot.img bs=512 count=1 conv=notrunc
bochs -f bochsrc.txt
