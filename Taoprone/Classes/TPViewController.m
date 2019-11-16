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

@end
