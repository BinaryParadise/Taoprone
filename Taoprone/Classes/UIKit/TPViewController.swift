//
//  TPViewController.m
//  Taoprone
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

import UIKit
import JavaScriptCore

class TPViewController: UIViewController, TPJSExport {
    func __invoke(_ typeInfo: [String : Any], _ method: String, _ arguments: [Any]) -> Any? {
        return nil
    }
    
    func __add(_ typeInfo: [String : Any], _ function: JSValue, _ name: String) {
        
    }    
    
    var functions: [String : JSValue] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let name = #function
        if let value = functions[name] {
            value.call(withArguments: nil)
        }
    }
}
