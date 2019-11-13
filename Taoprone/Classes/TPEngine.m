//
//  TPEngine.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

#import "TPEngine.h"
#import "TPViewJSExportImpl.h"

static JSContext *jsContext;

@interface TPEngine ()

@end

@implementation TPEngine

+ (id)moduleWithURL:(NSString *)filePath {
    static NSString *_regexStr = @"(?<!\\\\)\\.\\s*(\\w+)\\s*\\(";
    static NSString *_replaceStr = @".__c(\"$1\")(";
    NSRegularExpression* _regex;
    NSString *jsEngine = [NSString stringWithContentsOfFile:[[self sdkBundle] pathForResource:@"engine.js" ofType:nil] encoding:NSUTF8StringEncoding error:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    _regex = [NSRegularExpression regularExpressionWithPattern:_regexStr options:0 error:nil];
    jsContent = [_regex stringByReplacingMatchesInString:jsContent options:0 range:NSMakeRange(0, jsContent.length) withTemplate:_replaceStr];
    
    if (!jsContext) {
        jsContext = [[JSContext alloc] initWithVirtualMachine:[JSVirtualMachine new]];
    }
    jsContext.exceptionHandler = ^(JSContext *context, JSValue *exception) {
        NSLog(@"%@", exception);
    };
    jsContext[@"TPBridge"] = [[TPBridgeExport alloc] init];
    [jsContext evaluateScript:[jsEngine stringByAppendingString:jsContent]];
    jsContext[@"hellooc"] =  ^() {
        NSLog(@"HelloWord");
    };
    return [jsContext[@"initModule"] callWithArguments:nil].toObject;
}

+ (NSBundle *)sdkBundle {    
    NSString *path = [[NSBundle bundleForClass:self.class] pathForResource:@"Taoprone.bundle" ofType:nil];
    return [NSBundle bundleWithPath:path];
}

@end
