//
//  NSDate-Extension.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/16.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        
        let interval = Int(nowDate.timeIntervalSince1970)
        
        return "\(interval)"
    }
}
