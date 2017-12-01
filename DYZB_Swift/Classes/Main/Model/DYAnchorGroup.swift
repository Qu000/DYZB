//
//  DYAnchorGroup.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/16.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYAnchorGroup: DYBaseGameModel {
    /** 该组中的房间信息 */
    var room_list : [[String : NSObject]]?{
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(DYAnchorModel(dict: dict))
            }
        }
    }
    /// 该组的title
    /// 该组应显示的图标url
    var icon_name : String = "home_header_normal"
    /// 游戏对应的图标
    
    /// 定义主播的模型对象数组
    lazy var anchors : [DYAnchorModel] = [DYAnchorModel]()
  
}
