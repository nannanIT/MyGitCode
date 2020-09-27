//
//  Prime.c
//  MyGitCode
//
//  Created by jayhuan on 2020/9/22.
//

#include "Prime.h"

int isPrime(int n) {
    if (n <= 1) {
        return 0;
    }
    int result = 1;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            result = 0;
            break;
        }
    }
    return result;
}

int isPrime2(int n) {
    if (n <= 1) {
        return 0;
    }
    int result = 1;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            result = 0;
            break;
        }
    }
    return result;
}

int isPrime3(int n) {
    if (n <= 1) {
        return 0;
    }
    int result = 1;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            result = 0;
            break;
        }
    }
    return result;
}


int isPrime4(int n) {
    if (n <= 1) {
        return 0;
    }
    int result = 1;
    for (int i = 0; i * i <= n; i++) {
        if (n % i == 0) {
            result = 0;
            break;
        }
    }
    return result;
}

int isPrime5(int n) {
    if (n <= 1) {
        return 0;
    }
    int result = 1;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) {
            result = 0;
            break;
        }
    }
    return result;
}
