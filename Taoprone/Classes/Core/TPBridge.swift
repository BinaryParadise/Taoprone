//
//  SNViewJSExportImpl.m
//  FoundationDemo
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

import Foundation
import JavaScriptCore

@objc public protocol TPJSExport: JSExport {
    func __invoke(_ typeInfo: [String : Any], _ method: String, _ arguments: [Any]) -> Any?
    func __add(_ typeInfo: [String : Any], _ function: JSValue, _ name: String)
    var functions: [String: JSValue] { get set }
}

let __oc_obj        = "__oc_obj"
let __oc_className  = "__oc_class"
let __oc_isObj      = "__oc_isObj"

class TPBridge: NSObject, TPJSExport {
    var functions: [String : JSValue] = [:]
    
    var isObject: Bool = false
    
        
    func __invoke(_ typeInfo: [String : Any], _ method: String, _ arguments: [Any]) -> Any? {
        guard let cls: AnyClass = NSClassFromString(typeInfo[__oc_className] as! String) else { return nil }
        let sel = NSSelectorFromString("init")
        let methodSignature = si_methodSignature(for: sel)
        let invocation = SIInvocation(methodSignature: methodSignature)
        if let obj = typeInfo[__oc_obj] {
            invocation.target = obj as AnyObject
        } else {
            invocation.target = cls
        }
        for (index,arg) in arguments.enumerated() {
            var na = arg
            invocation.setArgument(&na, at: index)
        }
        invocation.invoke()
        var returnValue: Unmanaged<AnyObject>?
        invocation.getReturnValue(&returnValue)        
        return returnValue
    }
    
    func __add(_ typeInfo: [String : Any], _ function: JSValue, _ name: String) {
        guard let obj = typeInfo[__oc_obj] as? TPJSExport else { return }
        obj.functions[name] = function
    }
}
