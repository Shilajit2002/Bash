#include<sys/types.h>
#include<stdio.h>
#include<unistd.h>

int main(){
    int x;
    printf("Hello I am Main Method\n");
    printf("X is Calling fork()\n");
    x=fork();
    printf("Value of X : %d\n",x);
    printf("End");
    return 0;
}

pid_t fork(){
    printf("I am fork() Method\n");
    printf("Now I Sleep for 5s\n");
    sleep(5);
    return 5;
}