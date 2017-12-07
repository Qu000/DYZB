//
//  DYCustomNavigationController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/7.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYCustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器的tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: true)
    
    }
}
