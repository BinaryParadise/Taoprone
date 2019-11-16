//
//  SNBridgeDefine.h
//  FoundationDemo
//
//  Created by Rakey Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavascriptCore/JavascriptCore.h>

@protocol TPJSExport <JSExport>

JSExportAs(__invoke,- (id)invoke:(NSDictionary *)typeInfo method:(NSString *)method arguments:(NSArray *)arguments);

JSExportAs(__addFunction, - (void)invoke:(NSDictionary *)typeInfo addFunction:(JSValue *)function forName:(NSString *)name);

@end
