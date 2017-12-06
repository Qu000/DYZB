//
//  DYBaseViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYBaseViewController: UIViewController {

    // MARK: - 定义属性
    var contentView : UIView?
    
    // MARK: - 懒加载属性
    fileprivate lazy var animImageView : UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "img_loading_1"))
        
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!,UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        
        imageView.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
        return imageView
    }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension DYBaseViewController {
    func setupUI() {
        //1.隐藏内容的view
        contentView?.isHidden = true
        
        //2.添加执行动画的UIImageView
        view.addSubview(animImageView)
        
        //3.animImageView---执行动画
        animImageView.startAnimating()
        
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
    
    
    func loaddataFinished() {
        //1.停止动画
        animImageView.stopAnimating()
       
        //2.隐藏
        animImageView.isHidden = true
        
        //3.显示内容的View
        contentView?.isHidden = false
    }
}
