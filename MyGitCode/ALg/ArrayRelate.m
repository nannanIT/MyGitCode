//
//  ArrayRelate.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/22.
//

#import "ArrayRelate.h"

int maxSequenceSum(int A[], int len) {
    if (len <= 0) {
        return 0;
    }
    int max = A[0];
    int subMax = max;
    for (int i = 1; i < len; i++) {
        subMax = MAX(subMax + A[i], A[i]);
        max = MAX(subMax, max);
    }
    return max;
}

void maxSequenceSumTest(void) {
    int A[] = {1, 2, 3, -2, 6, -3, 0, 2, -2};
    int max = maxSequenceSum(A, 9);
    assert(max == 10);
}

@implementation ArrayRelate

@end
