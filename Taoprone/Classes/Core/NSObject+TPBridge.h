//
//  SNViewJSExportImpl.h
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "TPBridgeDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TPBridge)

@property (nonatomic, strong) NSMutableDictionary<NSString *, JSValue *> *functions;

@end

@interface TPBridgeExport : NSObject <TPJSExport>

@property (nonatomic, weak) JSContext *context;


@end

NS_ASSUME_NONNULL_END
