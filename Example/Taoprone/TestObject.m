//
//  TestObject.m
//  Taoprone_Example
//
//  Created by Rake Yang on 2021/7/6.
//  Copyright © 2021 Rake Yang. All rights reserved.
//

#import "TestObject.h"

@implementation TestObject

- (instancetype)init {
    if (self = [super init]) {
        self.tip = @"为什么对象释放不掉";
    }
    return self;
}

- (void)dealloc {
    NSLog(@"%s+%d %@", __FUNCTION__, __LINE__, self.tip);
}

@end
