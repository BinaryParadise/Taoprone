//
//  TPViewController.m
//  Taoprone
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TPViewController.h"

@interface TPViewController ()

@end

@implementation TPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillLayoutSubviews];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillLayoutSubviews];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillLayoutSubviews];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)didMoveToParentViewController:(UIViewController *)parent {
    if (!parent) {
        [self.functions.copy enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, JSValue * _Nonnull obj, BOOL * _Nonnull stop) {
            [obj.context.virtualMachine removeManagedReference:obj withOwner:self];
        }];
        [self.functions removeAllObjects];
    }
}

- (void)dealloc
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
}

@end
