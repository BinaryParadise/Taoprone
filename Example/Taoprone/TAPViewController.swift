//
//  TAPViewController.m
//  Taoprone
//
//  Created by Rake Yang 11/12/2019.
//  Copyright (c) 2019 BinaryParadise All rights reserved.
//

import UIKit
import JavaScriptCore
import WebKit
import Taoprone
import SnapKit

class TAPViewController: UIViewController {
    @IBOutlet weak var loadButton: UIButton!
    var webView: WKWebView?
    var engine: TPEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func reloadJS(sender: UIButton) {
        let filePath = Bundle.main.path(forResource: "main.js", ofType: nil)
        do {
            engine = TPEngine()
            let moduleVC = try engine?.moduleWithURL(filePath: filePath!)
            if let moduleVC = moduleVC {
                navigationController?.pushViewController(moduleVC, animated: true)
            }
        } catch {
            print("\(error)")
        }
    }
    
    @IBAction func debugJS(sender: UIButton) {
        var cachePath = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!.appending("/Taoprone")
        
        let conf = WKWebViewConfiguration()
        conf.userContentController.addUserScript(WKUserScript(source: try! String(contentsOfFile: "\(cachePath)/main.js", encoding: .utf8), injectionTime: .atDocumentStart, forMainFrameOnly: false))
        webView = WKWebView(frame: .zero, configuration: conf)
        view.addSubview(webView!)
        webView?.snp.makeConstraints({ make in
            make.top.equalTo(loadButton.snp.bottom).offset(30)
            make.bottom.right.left.equalToSuperview()
        })
        webView?.loadFileURL(URL(fileURLWithPath: Bundle.main.path(forResource: "index.html", ofType: nil)!), allowingReadAccessTo: Bundle.main.bundleURL)
    }

}
