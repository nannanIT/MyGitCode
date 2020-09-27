//
//  Tree.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/22.
//

#import "Tree.h"
#import "Stack.h"

@interface TreeNode : NSObject
@property(nonatomic, assign) NSInteger value;
@property(nonatomic, strong) TreeNode *leftChild;
@property(nonatomic, strong) TreeNode *rightChild;
@end

@implementation TreeNode

- (instancetype)initWithValue:(NSInteger)value {
    if (self = [super init]) {
        self.value = value;
    }
    return self;
}

@end

void visit(TreeNode *node) {
    if (!node) {
        return;
    }
    NSLog(@"%@", @(node.value));
}

void preTravelTree(TreeNode *tree) {
    if (!tree) {
        return;
    }
    Stack *stack = [Stack new];
    [stack push:tree];
    while (![stack isEmpty]) {
        TreeNode *node = [stack pop];
        visit(node);
        [stack push:node.rightChild];
        [stack push:node.leftChild];
    }
}

void inTravelTree(TreeNode *tree) {
    if (!tree) {
        return;
    }
    TreeNode *node = tree;
    Stack *stack = [Stack new];
    while (node || ![stack isEmpty]) {
        while (node) {
            [stack push:node];
            node = node.leftChild;
        }
        node = [stack pop];
        visit(node);
        node = node.rightChild;
    }
}

void postTravelTree(TreeNode *tree) {
    if (!tree) {
        return;
    }
    Stack *stack = [Stack new];
    [stack push:tree];
    NSMutableSet<TreeNode *> *visitedNode = [NSMutableSet set];
    while (![stack isEmpty]) {
        TreeNode *node = [stack top];
        if ((!node.leftChild || [visitedNode containsObject:node.leftChild])
            && (!node.rightChild || [visitedNode containsObject:node.rightChild])) {
            visit(node);
            [stack pop];
            [visitedNode addObject:node];
        } else {
            [stack push:node.rightChild];
            [stack push:node.leftChild];
        }
    }
}

void insertSortNode(TreeNode *node, NSInteger value) {
    if (!node) {
        return;
    }
    if (value <= node.value) {
        if (node.leftChild) {
            insertSortNode(node.leftChild, value);
        } else {
            node.leftChild = [[TreeNode alloc] initWithValue:value];
        }
    } else {
        if (node.rightChild) {
            insertSortNode(node.rightChild, value);
        } else {
            node.rightChild = [[TreeNode alloc] initWithValue:value];
        }
    }
}

void testInsertSort() {
    TreeNode *tree = [[TreeNode alloc] initWithValue:6];
    NSInteger A[] = {6, 2, 4, 5, 3, 8 , 1, 7};
    for (NSInteger i = 1; i < 8; i++) {
        insertSortNode(tree, A[i]);
    }
    preTravelTree(tree);
}

void treeTest() {
    TreeNode *tree1 = [[TreeNode alloc] initWithValue:1];
    TreeNode *tree2 = [[TreeNode alloc] initWithValue:2];
    TreeNode *tree3 = [[TreeNode alloc] initWithValue:3];
    TreeNode *tree4 = [[TreeNode alloc] initWithValue:4];
    TreeNode *tree5 = [[TreeNode alloc] initWithValue:5];
    TreeNode *tree6 = [[TreeNode alloc] initWithValue:6];
    TreeNode *tree7 = [[TreeNode alloc] initWithValue:7];
    TreeNode *tree8 = [[TreeNode alloc] initWithValue:8];
    tree1.leftChild = tree2;
    tree1.rightChild = tree3;
    tree2.leftChild = tree4;
    tree2.rightChild = tree5;
    tree4.leftChild = tree8;
    tree3.leftChild = tree6;
    tree3.rightChild = tree7;
//    preTravelTree(tree1);
//    inTravelTree(tree1);
//    postTravelTree(tree1);
    testInsertSort();
}

@implementation Tree

@end
