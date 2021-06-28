//
//  TPEngine.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

#import "TPEngine.h"
#import "NSObject+TPBridge.h"

static JSContext *jsContext;

@interface TPEngine ()

@property (nonatomic, strong) JSContext *jsContext;


@end

@implementation TPEngine

- (id)moduleWithURL:(NSString *)filePath {
    static NSString *_regexStr = @"(?<!\\\\)\\.\\s*(\\w+)\\s*\\(";
    static NSString *_replaceStr = @".__c(\"$1\")(";
    NSRegularExpression* _regex;
    //引擎
    NSString *jsEngine = [NSString stringWithContentsOfFile:[[self.class sdkBundle] pathForResource:@"engine.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _regex = [NSRegularExpression regularExpressionWithPattern:_regexStr options:0 error:nil];
    jsContent = [_regex stringByReplacingMatchesInString:jsContent options:0 range:NSMakeRange(0, jsContent.length) withTemplate:_replaceStr];
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/Taoprone"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:cachePath]) {
        [[NSFileManager defaultManager] createDirectoryAtPath:cachePath withIntermediateDirectories:YES attributes:nil error:nil];
    }

    //合并业务脚本
    NSString *merged = [jsEngine stringByAppendingString:jsContent];
    NSString *mainJS = [cachePath stringByAppendingString:@"/main.js"];
    [merged writeToFile:mainJS atomically:YES encoding:NSUTF8StringEncoding error:nil];

    if (!jsContext) {
        jsContext = [[JSContext alloc] initWithVirtualMachine:[JSVirtualMachine new]];
    }
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"%@", exception);
    };
    jsContext[@"TPBridge"] = [[TPBridgeExport alloc] init];
    [jsContext evaluateScript:merged withSourceURL:[NSURL fileURLWithPath:mainJS]];
    jsContext[@"console"][@"log"] = ^(NSString *msg) {
        NSLog(@"%@", msg);
    };
    jsContext[@"console"][@"error"] = ^(NSString *msg) {
        NSLog(@"error: %@", msg);
    };
    return [jsContext[@"initModule"] callWithArguments:nil].toObject;
}

+ (NSBundle *)sdkBundle {    
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"Taoprone.bundle" ofType:nil];
    return [NSBundle bundleWithPath:path];
}

- (void)dealloc {
    self.jsContext = nil;
}

@end
