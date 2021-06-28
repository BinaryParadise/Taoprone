//
//  TPEngine.h
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>

/**
 驱动引擎
 */
@interface TPEngine : NSObject

- (id)moduleWithURL:(NSString *)filePath;

+ (NSBundle *)sdkBundle;

@end
