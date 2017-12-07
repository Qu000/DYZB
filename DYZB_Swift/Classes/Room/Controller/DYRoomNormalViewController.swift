//
//  DYRoomNormalViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYRoomNormalViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.orange

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //隐藏导航栏(系统默认手势消除了)
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        //保持手势
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
