//
//  TPEngine.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

#import "TPEngine.h"
#import "NSObject+TPBridge.h"

@interface TPEngine ()

@property (nonatomic, strong) JSContext *jsContext;


@end

@implementation TPEngine

- (instancetype)init {
    if (self = [super init]) {
        self.jsContext = [[JSContext alloc] initWithVirtualMachine:[JSVirtualMachine new]];
        self.jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
            NSLog(@"%@", exception);
        };
        //解释引擎
        NSString *enginePath = [[self.class sdkBundle] pathForResource:@"engine.js" ofType:nil];
        NSString *jsEngine = [NSString stringWithContentsOfFile:enginePath encoding:NSUTF8StringEncoding error:nil];
        [self.jsContext evaluateScript:jsEngine withSourceURL:[NSURL fileURLWithPath:enginePath]];
    }
    return self;
}

- (id)moduleWithURL:(NSString *)filePath {
    static NSString *_regexStr = @"(?<!console)\\.\\s*(\\w+)\\s*\\(";
    static NSString *_replaceStr = @".__c(\"$1\")(";
    NSRegularExpression* _regex;
    //解释引擎
    NSString *jsContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _regex = [NSRegularExpression regularExpressionWithPattern:_regexStr options:0 error:nil];
    jsContent = [_regex stringByReplacingMatchesInString:jsContent options:0 range:NSMakeRange(0, jsContent.length) withTemplate:_replaceStr];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/Taoprone"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSString *mainJS = [cachePath stringByAppendingString:@"/main.js"];
    [jsContent writeToFile:mainJS atomically:YES encoding:NSUTF8StringEncoding error:nil];

    TPBridgeExport *bridge = [TPBridgeExport new];
    bridge.context = self.jsContext;
    self.jsContext[@"TPBridge"] = bridge;
    [self.jsContext evaluateScript:jsContent withSourceURL:[NSURL fileURLWithPath:mainJS]];
    self.jsContext[@"nslog"] = ^(NSString *msg) {
        NSLog(@"%@", msg);
    };
    return [self.jsContext[@"initModule"] callWithArguments:nil].toObject;
}

+ (NSBundle *)sdkBundle {    
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"Taoprone.bundle" ofType:nil];
    return [NSBundle bundleWithPath:path];
}

- (void)dealloc {
    self.jsContext = nil;
    NSLog(@"%s+%d", __FUNCTION__, __LINE__);
}

@end
