//
//  NSInvocation+ScriptNative.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/29.
//  Copyright © 2019年 BinaryParadise. All rights reserved.
//

#import "NSInvocation+Taoprone.h"
#import <objc/runtime.h>
#import <MCJSONKit/MCJSONKit.h>

@implementation NSInvocation (Taoprone)

- (void)setArgumentWithObject:(id)obj atIndex:(NSUInteger)index {
    const char *argType = [self.methodSignature getArgumentTypeAtIndex:index];
    if (strncmp(@encode(long), argType, 1) == 0) {
        long value = [(NSNumber *)obj longValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(CGRect), argType, 1) == 0) {
        NSDictionary *dict = obj;
        CGRect value = CGRectMake([dict mc_doubleForKey:@"x"], [dict mc_doubleForKey:@"y"], [dict mc_doubleForKey:@"width"], [dict mc_doubleForKey:@"height"]);
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(CGSize), argType, 1) == 0) {
        NSDictionary *dict = obj;
        CGSize size = CGSizeMake([dict mc_doubleForKey:@"width"], [dict mc_doubleForKey:@"height"]);
        [self setArgument:&size atIndex:index];
    } else if (strncmp(@encode(NSUInteger), argType, 1) == 0) {
        NSUInteger value = [obj unsignedIntegerValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(NSInteger), argType, 1) == 0) {
        NSInteger value = [obj integerValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(double), argType, 1) == 0) {
        double value = [obj doubleValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(int), argType, 1) == 0) {
        NSUInteger value = [obj unsignedIntegerValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(long), argType, 1) == 0) {
        NSUInteger value = [obj unsignedIntegerValue];
        [self setArgument:&value atIndex:index];
    } else if (strncmp(@encode(id), argType, 1) == 0) {
        id value = obj;
        [self setArgument:&value atIndex:index];
    } else {
        void *value;
        [self setArgument:&value atIndex:index];
    }
}

@end
