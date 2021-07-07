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
#import "TestObject.h"

@interface TAPViewController ()

@property (nonatomic, weak) IBOutlet UIButton *loadButton;
@property (nonatomic, weak) IBOutlet UIButton *unloadButton;
@property (nonatomic, strong) TPEngine *engine;


@end

@implementation TAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)reloadJS:(UIButton *)sender {
    sender.enabled = false;
    self.unloadButton.enabled = true;
    self.engine = TPEngine.new;
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"main.js" ofType:nil];
    UIViewController *moduleVC = [self.engine moduleWithURL:filePath];
    if (moduleVC) {
        [self.navigationController pushViewController:moduleVC animated:YES];
    }
}

- (IBAction)unloadJS:(id)sender {
    self.engine = nil;
    self.loadButton.enabled = true;
    self.unloadButton.enabled = false;
}

- (IBAction)testJS:(id)sender {
    JSContext *ctx = [[JSContext alloc] init];
    JSValue *r = [ctx evaluateScript:@"3+7"];
    JSValue *jv = [JSValue valueWithObject:[TestObject new] inContext:ctx];
//    [ctx.virtualMachine addManagedReference:jv withOwner:self];
}

- (void)dealloc {
    NSLog(@"%s+%d", __FUNCTION__, __LINE__);
}

@end
