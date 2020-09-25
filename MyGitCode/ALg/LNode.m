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
    if (head == nil || k <= 0) {
        return nil;
    }
    LNode *node = head;
    while (node != nil && k > 1) {
        node = node.next;
        k--;
    }
    return node;
}

LNode *findLastKthNode(LNode *head, NSInteger k) {
    if (!head || k <= 0) {
        return nil;
    }
    NSInteger len = lengthOfLNode(head);
    if (k > len) {
        return nil;
    }
    return findKthNode(head, len - k + 1);
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
    LNode *node = findKthNode(head, 1);
    assert(node != nil && node.value == 0);
    node = findKthNode(head, 7);
    assert(node.value == 6);
    node = findKthNode(head, 0);
    assert(node == nil);
    node = findKthNode(head, 8);
    assert(node == nil);
    node = findKthNode(head, 9);
    assert(node == nil);
    
    node = findLastKthNode(head, 1);
    assert(node.value == 6);
    node = findLastKthNode(head, 7);
    assert(node.value == 0);
    node = findLastKthNode(head, 0);
    assert(node == nil);
    node = findLastKthNode(head, 8);
    assert(node == nil);
}

@implementation LNode

@end
