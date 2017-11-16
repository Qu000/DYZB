//
//  DYCollectionPrettyCell.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/15.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionPrettyCell: DYCollectionBaseCell {
    // MARK: - 控件属性
    
    @IBOutlet weak var cityBtn: UIButton!
    // MARK: -模型属性
    override var anchor : DYAnchorModel?{
        didSet{
            // 1.将属性传递给父类
            super.anchor = anchor
            
            cityBtn.setTitle(anchor?.anchor_city, for: UIControlState.normal)
            
            
            
        }
    }
    

}
