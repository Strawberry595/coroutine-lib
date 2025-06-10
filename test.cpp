#include <stdio.h>
#include <ucontext.h>
#include <stdlib.h> 

void func1(){
    puts("In func1");
}

int main(){
    ucontext_t context;
    getcontext(&context);
    context.uc_stack.ss_sp = malloc(1024);
    context.uc_stack.ss_size = 1024;
    context.uc_link = NULL;
    makecontext(&context, func1, 0);
    setcontext(&context);
    puts("dddddd");
    return 0;
}