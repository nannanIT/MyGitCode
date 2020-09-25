//
//  Stack.h
//  MyGitCode
//
//  Created by jayhuan on 2020/9/24.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stack : NSObject

- (void)push:(id)obj;
- (nullable id)pop;
- (nullable id)top;
- (BOOL)isEmpty;

@end

NS_ASSUME_NONNULL_END
