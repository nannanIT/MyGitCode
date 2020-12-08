#  Compile

gcc -E main.c -o main.i
gcc -S main.c -o mian.s
gcc -c main.c -o mian.o
gcc main.c -o main.out
file mian.o
objdump -d main.o
```
main.o:    file format Mach-O 64-bit x86-64


Disassembly of section __TEXT,__text:

0000000000000000 _main:
       0: 55                               pushq    %rbp
       1: 48 89 e5                         movq    %rsp, %rbp
       4: 48 83 ec 20                      subq    $32, %rsp
       8: c7 45 fc 00 00 00 00             movl    $0, -4(%rbp)
       f: 89 7d f8                         movl    %edi, -8(%rbp)
      12: 48 89 75 f0                      movq    %rsi, -16(%rbp)
      16: 8b 35 00 00 00 00                movl    (%rip), %esi
      1c: 48 8d 3d 2f 00 00 00             leaq    47(%rip), %rdi
      23: b0 00                            movb    $0, %al
      25: e8 00 00 00 00                   callq    0 <_main+0x2a>
      2a: 31 c9                            xorl    %ecx, %ecx
      2c: 89 45 ec                         movl    %eax, -20(%rbp)
      2f: 89 c8                            movl    %ecx, %eax
      31: 48 83 c4 20                      addq    $32, %rsp
      35: 5d                               popq    %rbp
      36: c3                               retq
      37: 66 0f 1f 84 00 00 00 00 00       nopw    (%rax,%rax)

0000000000000040 _add:
      40: 55                               pushq    %rbp
      41: 48 89 e5                         movq    %rsp, %rbp
      44: 89 7d fc                         movl    %edi, -4(%rbp)
      47: 89 75 f8                         movl    %esi, -8(%rbp)
      4a: 8b 45 fc                         movl    -4(%rbp), %eax
      4d: 03 45 f8                         addl    -8(%rbp), %eax
      50: 5d                               popq    %rbp
      51: c3                               retq
```
objdump -h main.o
```
Sections:
Idx Name             Size     VMA              Type
  0 __text           00000052 0000000000000000 TEXT
  1 __cstring        00000013 0000000000000052 DATA
  2 __data           00000004 0000000000000068 DATA
  3 __compact_unwind 00000040 0000000000000070 DATA
  4 __eh_frame       00000068 00000000000000b0 DATA
```

### 注意三种变化
- 栈空间变化
- 栈中的数据值变化
- 寄存器数据值变化

```
#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main(int argc, const char * argv[]) {
    int a = 2, b = 3;
    int c = add(a, b);
    printf("a + b = %d\n", c);
    return 0;
}
```

```
_add:
    pushq    %rbp
    movq    %rsp, %rbp
    movl    %edi, -4(%rbp)
    movl    %esi, -8(%rbp)
    movl    -4(%rbp), %eax
    addl    -8(%rbp), %eax
    popq    %rbp
    retq
    
_main:
    pushq    %rbp
    movq    %rsp, %rbp
    subq    $32, %rsp
    movl    $0, -4(%rbp)
    movl    %edi, -8(%rbp)
    movq    %rsi, -16(%rbp)
    movl    $2, -20(%rbp)
    movl    $3, -24(%rbp)
    movl    -20(%rbp), %edi
    movl    -24(%rbp), %esi
    callq    _add
    movl    %eax, -28(%rbp)
    movl    -28(%rbp), %esi
    leaq    L_.str(%rip), %rdi
    movb    $0, %al
    callq    _printf
    xorl    %ecx, %ecx
    movl    %eax, -32(%rbp)         ## 4-byte Spill(溢出)
    movl    %ecx, %eax
    addq    $32, %rsp
    popq    %rbp
    retq
```

```
#include <stdio.h>

int add(int a, int b) {
    return a + b;
}

int main(int argc, const char * argv[]) {
    int a = 2, b = 3;
    int c = add(a, b);
    return 0;
}
```

```
_add:                                   ## @add
## %bb.0:
pushq    %rbp
movq    %rsp, %rbp
movl    %edi, -4(%rbp)
movl    %esi, -8(%rbp)
movl    -4(%rbp), %eax
addl    -8(%rbp), %eax
popq    %rbp
retq

_main:                                  ## @main
pushq    %rbp
movq    %rsp, %rbp
subq    $32, %rsp
movl    $0, -4(%rbp)
movl    %edi, -8(%rbp)
movq    %rsi, -16(%rbp)
movl    $2, -20(%rbp)
movl    $3, -24(%rbp)
movl    -20(%rbp), %edi
movl    -24(%rbp), %esi
callq    _add
xorl    %ecx, %ecx
movl    %eax, -28(%rbp)
movl    %ecx, %eax
addq    $32, %rsp
popq    %rbp
retq
```
