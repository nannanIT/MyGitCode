//
//  Sort.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/21.
//

#import "Sort.h"

static int A[4] = {2, 3, 4, 1};
static int B[4] = {4, 3, 2, 1};
static int test[][4] = {{2, 3, 4, 1}, {4, 3, 2, 1}};

void printArray(int A[], int len) {
    for (int i = 0; i < len; i++) {
        printf("%d,", A[i]);
    }
    printf("\n");
}

void validateOrderedArray(int A[], int len) {
    for (int i = 0; i < len - 1; i++) {
        assert(A[i] <= A[i+1]);
    }
}

void swap(int A[], int n, int m) {
    if (n == m) {
        return;
    }
    int t = A[n];
    A[n] = A[m];
    A[m] = t;
}

void bubbleSort(int A[], int len) {
    for (int k = 1; k < len; k++) {
        for (int i = 0; i < len - k; i++) {
            if (A[i] > A[i+1]) {
                swap(A, i, i+1);
            }
        }
    }
}

void bubbleTest() {
    bubbleSort(A, 4);
    validateOrderedArray(A, 4);
    bubbleSort(B, 4);
    validateOrderedArray(B, 4);
    for (int i = 0; i < 2; i++) {
        printf("pre bubble sort :\n");
        printArray(test[i], 4);
        bubbleSort(test[i], 4);
        printf("after bubble sort :\n");
        printArray(test[i], 4);
        validateOrderedArray(test[i], 4);
    }
}

void quickSort(int A[], int first, int last) {
    if (first >= last) {
        return;
    }
    int target = A[first];
    int begin = first;
    int end = last;
    while (begin < end) {
        while (begin < end && A[end] >= target) {
            end--;
        }
        A[begin] = A[end];
        while (begin < end && A[begin] <= target) {
            begin++;
        }
        A[end] = A[begin];
    }
    int mid = begin;
    A[mid] = target;
    quickSort(A, first, mid - 1);
    quickSort(A, mid + 1, last);
}

void quickSort2(int A[], int first, int last) {
    if (first >= last) {
        return;
    }
    int target = A[first];
    int begin = first;
    int end = last;
    while (begin < end) {
        while (begin < end && A[end] >= target) {
            end--;
        }
        swap(A, begin, end);
        while (begin < end && A[begin] <= target) {
            begin++;
        }
        swap(A, begin, end);
    }
    int mid = begin;
    quickSort(A, first, mid - 1);
    quickSort(A, mid + 1, last);
}

void quickSortTest() {
    quickSort2(A, 0, 4);
    validateOrderedArray(A, 4);
    quickSort2(B, 0, 4);
    validateOrderedArray(B, 4);
}

@implementation Sort

@end
