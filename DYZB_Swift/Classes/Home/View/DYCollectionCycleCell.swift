//
//  DYCollectionCycleCell.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
import Kingfisher

class DYCollectionCycleCell: UICollectionViewCell {
    // MARK: - 控件属性
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var titleLab: UILabel!
    // MARK: - 定义模型属性
    var cycleModel : DYCycleModel?{
        didSet{
            titleLab.text = cycleModel?.title
            let iconURL = URL(string: cycleModel?.pic_url ?? "")!
            iconImg.kf.setImage(with: iconURL, placeholder: UIImage(named: "Img_default"))
            
        }
    }
    


}
