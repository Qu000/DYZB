//
//  DYRecommedCycleView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYRecommedCycleView: UIView {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
    }

}
// MARK: - 提供一个快速创建view的类方法
extension DYRecommedCycleView {
    class func recommedCycleView() -> DYRecommedCycleView {
        return Bundle.main.loadNibNamed("DYRecommedCycleView", owner: nil, options: nil)?.first as! DYRecommedCycleView
    }
}

