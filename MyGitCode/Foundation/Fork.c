//
//  Fork.c
//  MyGitCode
//
//  Created by jayhuan on 2020/10/20.
//

#include "Fork.h"
#include<stdio.h>
#include<unistd.h>


void forkTest() {
    int fd[2];
    pid_t pid;
    char buff[20];
    if (pipe(fd) < 0) {
        printf("Create pipe error!");
    }
    
    if ((pid = fork()) < 0) {
        printf("Fork error!");
    } else if (pid > 0) {
        close(fd[0]);
        write(fd[1], "Hello world", 18);
        printf("I am parent, pid:%d\n", pid);
    } else {
        close(fd[1]);
        read(fd[0], buff, 20);
        printf("%s, I am chlid, pid:%d\n", buff, pid);
    }
}
