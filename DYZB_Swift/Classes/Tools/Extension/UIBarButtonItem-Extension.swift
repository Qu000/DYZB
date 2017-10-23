//
//  UIBarButtonItem-Extension.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/23.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    /*
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem{
        let btn = UIButton()
        
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        return UIBarButtonItem(customView: btn)
    }
     */
    //便利构造函数：1.convenience开头。2.在构造函数中必须明确调用一个设计构造函数(self)
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero) {
        //创建button
        let btn = UIButton()
        btn.setImage(UIImage.init(named: imageName), for: .normal)
        
        //创建button的高亮图
        if highImageName != "" {
            btn.setImage(UIImage.init(named: highImageName), for: .highlighted)
        }
        
        //创建button的尺寸
        if size == CGSize.zero {
            btn.sizeToFit()
        }else{
            btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        
        //创建UIBarButtonItem
        self.init(customView: btn)
    }
}
