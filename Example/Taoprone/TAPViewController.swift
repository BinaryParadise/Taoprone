//
//  TAPViewController.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

import UIKit
import JavaScriptCore
import Taoprone

class TAPViewController: UIViewController {
    @IBOutlet weak var loadButton: UIButton!
    var engine: TPEngine?
    
    @IBAction func reloadJS(sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "main.js", ofType: nil)
        #if TARGET_IPHONE_SIMULATOR
        filePath = "/Users/rakeyang/Github/Taoprone/Example/Taoprone/main.js"
        #endif
        do {
            engine = TPEngine()
            if let moduleVC = try engine?.moduleWithURL(filePath: filePath!) as? UIViewController {
                navigationController?.pushViewController(moduleVC, animated: true)
            }
        } catch {
            print("\(error)")
        }
    }

}
