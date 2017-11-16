//
//  DYCollectionHeaderView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/15.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYCollectionHeaderView: UICollectionReusableView {

    // MARK: - 控件属性
    @IBOutlet weak var titleLab: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    // MARK: - 定义模型属性
    var group : DYAnchorGroup?{
        didSet {
            titleLab.text = group?.tag_name
            iconImg.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
