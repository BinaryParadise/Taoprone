//
//  TPButton.m
//  Taoprone
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TPButton.h"
#import "NSObject+TPBridge.h"

@implementation TPButton

- (IBAction)doAction:(UIButton *)sender {
    JSValue *value = [self.functions objectForKey:@"doActionFunction"];
    [value callWithArguments:@[self]];
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
    [super setTitle:title forState:state];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents {
    [super addTarget:self action:@selector(doAction:) forControlEvents:controlEvents];
}

@end
