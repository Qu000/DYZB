//
//  DYCollectionBaseCell.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/16.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYCollectionBaseCell: UICollectionViewCell {
    // MARK: - 控件属性
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var onLineBtn: UIButton!
    
    @IBOutlet weak var nicknameLab: UILabel!
    
    // MARK: - 模型属性
    
    var anchor : DYAnchorModel?{
        didSet{
            // 0.校验模型是否有值
            guard let anchor = anchor else { return }
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万人在线"
            } else {
                onlineStr = "\(anchor.online)人在线"
            }
            onLineBtn.setTitle(onlineStr, for: UIControlState.normal)
            
            nicknameLab.text = anchor.nickname
            
            // 3.设置封面图片
            guard let iconURL = URL(string: anchor.vertical_src) else { return }
            iconImg.kf.setImage(with: iconURL)
            
        }
    }
}
