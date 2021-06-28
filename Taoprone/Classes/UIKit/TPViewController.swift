//
//  TPViewController.m
//  Taoprone
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

import UIKit
import JavaScriptCore

class TPViewController: UIViewController {
    var functions: [String : Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    
/*- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    JSValue *value = [self.functions valueForKey:NSStringFromSelector(_cmd)];
    [value callWithArguments:nil];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
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

@end*/
