//
//  DYHomeViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/23.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//   /coderwhy/DouYuZB/tree/master/DYZB/DYZB

import UIKit

class DYHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

}
// MARK:--UI(swift3里用fileprivate; swift4里是private，取消了fileprivate)
extension DYHomeViewController {
    fileprivate func setupUI() {
        //设置导航栏
        setupNavigationBar()
    }
    private func setupNavigationBar() {
        //1.设置左侧的item(完成构造函数后，可改写)
//        let btn = UIButton()
//        btn.setImage(UIImage.init(named: "logo"), for: .normal)
//        btn.sizeToFit()
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView:btn)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName: "logo")
        //2.设置右侧的item
        let size = CGSize(width: 40, height: 40)
        
//        let historyBtn = UIButton()
//        historyBtn.setImage(UIImage.init(named: "image_my_history"), for: .normal)
//        historyBtn.setImage(UIImage.init(named: "Image_my_history_click"), for: .highlighted)
//        historyBtn.frame = CGRect(origin: CGPoint.zero, size: size);
//        let historyItem = UIBarButtonItem(customView: historyBtn)
        
//  重复代码，抽取出来，把扩展类方法了
//        let historyItem = UIBarButtonItem.createItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
//swift更加鼓励使用构造函数，所以将扩展类方法，换为构造函数
        
        
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        let qrcodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        
      
        navigationItem.rightBarButtonItems = [historyItem,searchItem,qrcodeItem];
      
    }
}
