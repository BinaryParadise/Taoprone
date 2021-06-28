//
//  TAPViewController.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

#import "TAPViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import <Taoprone/Taoprone.h>

@interface TAPViewController ()

@property (nonatomic, weak) IBOutlet UIButton *loadButton;
@property (nonatomic, strong) TPEngine *engine;


@end

@implementation TAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.engine = TPEngine.new;
}

- (IBAction)reloadJS:(UIButton *)buttong {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"main.js" ofType:nil];
    UIViewController *moduleVC = [self.engine moduleWithURL:filePath];
    if (moduleVC) {
        [self.navigationController pushViewController:moduleVC animated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
