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

LNode *findKthNode(LNode *head, NSInteger k) {
    LNode *node = head;
    while (node != nil && k > 0) {
        node = node.next;
        k--;
    }
    return node;
}

void lnodeTest() {
    LNode *head = [[LNode alloc] init];
    head.value = 0;
    head.next = nil;
    
    LNode *currentNode = head;
    for (int i = 1; i < 7; i++) {
        LNode *node = [[LNode alloc] init];
        node.value = i;
        node.next = currentNode.next;
        currentNode.next = node;
        currentNode = node;
    }
    NSInteger len = lengthOfLNode(head);
    assert(len == 7);
}

@implementation LNode

@end
