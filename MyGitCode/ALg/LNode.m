//
//  LNode.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/22.
//

#import "LNode.h"

@interface LNode ()
@property(nonatomic, assign) NSInteger value;
@property(nonatomic, strong) LNode *next;
@end

NSInteger lengthOfLNode(LNode *head) {
    if (head == nil) {
        return 0;
    }
    NSInteger len = 0;
    while (head != nil) {
        len++;
        head = head.next;
    }
    return len;
}

@implementation LNode

@end
