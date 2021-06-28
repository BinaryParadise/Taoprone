//
//  TPEngine.swift
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

import JavaScriptCore

public class TPEngine {
    private var jsContext = JSContext(virtualMachine: JSVirtualMachine())
    
    public init() {
        
    }
    
    public func moduleWithURL(filePath: String) throws -> Any! {
        guard let jsContext = jsContext else { return nil }
        let _regexStr = "(?<!\\\\)\\.\\s*(\\w+)\\s*\\("
        let _replaceStr = ".__c(\"$1\")("
        let _regex = try NSRegularExpression(pattern: _regexStr, options: .caseInsensitive)
        
        //解释引擎
        var jsEngine = try String(contentsOfFile: TPEngine.sdkBundle().path(forResource: "engine.js", ofType: nil)!)
        let jsContent = try String(contentsOfFile: filePath)
        let newContent = _regex.stringByReplacingMatches(in: jsContent, options: .reportProgress, range: NSMakeRange(0, jsContent.count), withTemplate: _replaceStr)
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.appending("/Taoprone")
        
        if !FileManager.default.fileExists(atPath: cachePath) {
            try FileManager.default.createDirectory(atPath: cachePath, withIntermediateDirectories: true, attributes: nil);
        }

        //拼接逻辑脚本
        jsEngine = jsEngine.appending("\n//--------------------业务代码----------------------\n")
        let merged = jsEngine.appending(newContent)
        let mainJS = cachePath.appending("/main.js")
        try merged.write(toFile: mainJS, atomically: true, encoding: .utf8)

        jsContext.exceptionHandler = { context, exception in
            print("exceptionHandler: \(String(describing: exception))")
        }
        jsContext.setObject(TPBridge(), forKeyedSubscript: NSString("TPBridge"))
        
        //block封装
        let willCallClosure: @convention(block) () -> String = {
            print("Hello, world!")
            return "0.1.0 (swift 2021-06-28)"
        }
        jsContext.setObject(willCallClosure, forKeyedSubscript: NSString("sayHelloToSwift"))
        jsContext.evaluateScript(merged, withSourceURL: URL(fileURLWithPath: mainJS))
        let result = jsContext.objectForKeyedSubscript("initModule").call(withArguments: nil)
        return result?.toObject
    }

    class func sdkBundle() -> Bundle {
        let path = Bundle(for: Self.self).path(forResource: "Taoprone.bundle", ofType: nil)
        return Bundle(path: path!)!
    }
    
    deinit {
        jsContext = nil
        print("\(self) \(#function)")
    }
}
