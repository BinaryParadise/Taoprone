//
//  SNViewJSExportImpl.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

#import "NSObject+TPBridge.h"
#import <objc/runtime.h>
#import <objc/message.h>
#import "UIColor+TPBridge.h"
#import "NSInvocation+Taoprone.h"
#import <MCJSONKit/MCJSONKit.h>

static NSString * const __oc_obj        = @"__oc_obj";
static NSString * const __oc_className  = @"__oc_class";
static NSString * const __oc_isObj      = @"__oc_isObj";

@implementation NSObject (TPBridge)

- (void)setFunctions:(NSMutableDictionary *)functions {
    objc_setAssociatedObject(self, @selector(functions), functions, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary *)functions {
    id obj = objc_getAssociatedObject(self, _cmd);
    if (!obj) {
        [self setFunctions:NSMutableDictionary.dictionary];
    }
    return objc_getAssociatedObject(self, _cmd);
}

@end

@implementation TPBridgeExport

- (NSInvocation *)invocationWithClass:(Class)cls target:(id)target method:(NSString *)method {
    NSMethodSignature *methodSign;
    SEL selector = NSSelectorFromString(method);
    if (target) {
        methodSign = [cls instanceMethodSignatureForSelector:selector];
    } else {
        methodSign = [cls methodSignatureForSelector:selector];
    }
    if (methodSign) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSign];
        invocation.target = target ? target : cls;
        invocation.selector = selector;
        return invocation;
    }
    NSLog(@"Can't find @selector(%@) in Class %@", method, cls);
    return nil;
}

- (id)invoke:(NSDictionary *)typeInfo method:(NSString *)method arguments:(NSArray *)arguments {
    Class cls = NSClassFromString([typeInfo mc_stringForKey:__oc_className]);
    id obj = typeInfo[__oc_obj];
    NSInvocation *invocation = [self invocationWithClass:cls target:obj method:method];
    if (!invocation) return nil;
    
    for (int i = 2; i<invocation.methodSignature.numberOfArguments; i++) {
        if (i - 2 < arguments.count) {
            [invocation setArgumentWithObject:arguments[i-2] atIndex:i];
        }
    }
    
    [invocation invoke];
    id returnValue;
    const char * returnType = invocation.methodSignature.methodReturnType;
    if (strncmp(returnType, "@", 1) == 0) {
        void *retVal;
        [invocation getReturnValue:&retVal];
        if ([method isEqualToString:@"alloc"]) {
            returnValue = (__bridge_transfer id)retVal;
        } else {
            returnValue = (__bridge id)retVal;
            //[self.context.virtualMachine addManagedReference:returnValue withOwner:self];
        }
        return @{__oc_className: NSStringFromClass([returnValue class]), __oc_obj: returnValue, __oc_isObj:@YES};
    } else if (strncmp(returnType, "v", 1) == 0) {
        return [NSNull null];
    } else if (strncmp(returnType, @encode(CGRect), 1) == 0) {
        CGRect rect = CGRectZero;
        [invocation getReturnValue:&rect];
        return [JSValue valueWithRect:rect inContext:[JSContext currentContext]];
    } else if (strncmp(returnType, @encode(CGSize), 1) == 0) {
        CGSize size = CGSizeZero;
        [invocation getReturnValue:&size];
        return [JSValue valueWithSize:size inContext:[JSContext currentContext]];
    } else {
        void *retVal;
        [invocation getReturnValue:&retVal];
        return (__bridge id)(retVal);
    }
    return @{__oc_className: NSStringFromClass([returnValue class]), __oc_obj: returnValue, __oc_isObj:@NO};
}

- (void)invoke:(NSDictionary *)typeInfo addFunction:(JSValue *)function forName:(NSString *)name {
    NSObject *obj = typeInfo[__oc_obj];
    if (name) {
        [self.context.virtualMachine addManagedReference:function withOwner:self.context];
        obj.functions[name] = function;
    }
}

- (void)dealloc {
    NSLog(@"%s+%d", __FUNCTION__, __LINE__);
}

@end
