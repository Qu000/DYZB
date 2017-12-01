//
//  DYBaseGameModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/1.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYBaseGameModel: NSObject {
    // MARK: - 定义属性
    
    /// 该组的title
    var tag_name : String = ""
    /// 游戏对应的图标
    var icon_url : String = ""
    
    
    // MARK: - 构造函数
    override init() {
        
    }
    
    // MARK: - 自定义构造函数
    init(dict : [String : Any]) {
        super.init()
        
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
