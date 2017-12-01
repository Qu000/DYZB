//
//  DYCollectionGameCell.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionGameCell: UICollectionViewCell {

    // MARK: - 控件属性
    @IBOutlet weak var iconImg: UIImageView!
  
    @IBOutlet weak var titleLab: UILabel!
    
    
    // MARK: - 定义模型数据//var group : DYAnchorGroup?
    var baseGame : DYBaseGameModel?{
        didSet {
            titleLab.text = baseGame?.tag_name
            
            if let iconURL = URL(string: baseGame?.icon_url ?? "") {
                iconImg.kf.setImage(with: iconURL)
            } else {
                iconImg.image = UIImage(named: "home_more_btn")
            }
        }
    }
    
    
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
