//
//  UIColor+TPBridge.m
//  Taoprone
//
//  Created by Rake Yang on 2019/6/28.
//  Copyright © 2019 BinaryParadise. All rights reserved.
//

import UIKit

extension UIColor {
    func tp_colorWithHex(_ hex: Int) -> Self {
        let red = (hex & 0xFF0000) >> 16
        let green = (hex & 0x00FF00) >> 8
        let blue = (hex & 0x00FF) >> 0
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: 1.0) as! Self
    }
}
