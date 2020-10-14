#  Compile

gcc -E main.c -o main.i
gcc -S main.c -o mian.s
gcc -c main.c -o mian.o
gcc main.c -o main.out
file mian.o
objdump -d main.o
objdump -h main.o

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
