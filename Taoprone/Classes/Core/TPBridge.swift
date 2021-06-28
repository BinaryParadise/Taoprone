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
    func __add(typeInfo: [String : Any], function: JSValue, for name: String)
    var isObject: Bool { get set}
    var functions: [String: Any] { get set }
}

let __oc_obj        = "__oc_obj"
let __oc_className  = "__oc_class"
let __oc_isObj      = "__oc_isObj"

class TPBridge: NSObject, TPJSExport {
    var functions: [String : Any] = [:]
    
    var isObject: Bool = false
    
        
    func __invoke(_ typeInfo: [String : Any], _ method: String, _ arguments: [Any]) -> Any? {
        let cls: AnyClass? = NSClassFromString(typeInfo[__oc_className] as! String)
        let sel = NSSelectorFromString(method)
        var result: Any?
        if let cls = cls {
            if method == "init" {
                if cls is TPViewController.Type {
                    result = TPViewController()
                }
            }
        }
        return result
    }
    
    func __add(typeInfo: [String : Any], function: JSValue, for name: String) {
        
    }
}
