//
//  Sort.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/21.
//

#import "Sort.h"

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
    int A[4] = {2, 3, 4, 1};
    int B[4] = {4, 3, 2, 1};
    bubbleSort(A, 4);
    validateOrderedArray(A, 4);
    bubbleSort(B, 4);
    validateOrderedArray(B, 4);
}

int partitation(int A[], int first, int last) {
    if (first >= last) {
        return first;
    }
    int target = A[first];
    while (first < last) {
        while (first < last && A[last] >= target) {
            last--;
        }
        A[first] = A[last];
        while (first < last && A[first] <= target) {
            first++;
        }
        A[last] = A[first];
    }
    int mid = first;
    A[mid] = target;
    return mid;
}

void quickSort(int A[], int first, int last) {
    if (first >= last) {
        return;
    }
    int mid = partitation(A, first, last);
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
    int A[4] = {2, 3, 4, 1};
    int B[4] = {4, 3, 2, 1};
    quickSort(A, 0, 4);
    validateOrderedArray(A, 4);
    quickSort(B, 0, 4);
    validateOrderedArray(B, 4);
}

@implementation Sort

@end
