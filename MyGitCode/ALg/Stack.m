//
//  Stack.m
//  MyGitCode
//
//  Created by jayhuan on 2020/9/24.
//

#import "Stack.h"

@interface Stack ()
@property(nonatomic, strong) NSMutableArray *stack;
@end

@implementation Stack

- (instancetype)init {
    if (self = [super init]) {
        self.stack = @[].mutableCopy;
    }
    return self;
}

- (void)push:(id)obj {
    if (!obj) {
        return;
    }
    [self.stack addObject:obj];
}

- (id)pop {
    if ([self isEmpty]) {
        return nil;
    }
    id obj = [self.stack lastObject];
    [self.stack removeLastObject];
    return obj;
}

- (nullable id)top {
    return [self.stack lastObject];
}

- (BOOL)isEmpty {
    return self.stack.count <= 0;
}

@end
