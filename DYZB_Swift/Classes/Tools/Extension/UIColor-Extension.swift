//
//  UIColor-Extension.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/24.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
