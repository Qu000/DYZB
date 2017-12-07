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

        //1.获取系统的pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        //2.获取手势添加到的view中
        guard let gesView = systemGes.view else { return }

        //3.获取target/action
        //3.1利用运行时机制，查看所有的属性名称
        /*
        var count : UInt32 = 0
        let ivars = class_copyIvarList(UIGestureRecognizer.self, &count)!
        for i in 0..<count {
            let ivar = ivars[Int(i)]
            let name = ivar_getName(ivar)
            print(String(cString : name!))
        }
        */
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObj = targets?.first else { return }
        
        //3.2取出target
        guard let target = targetObj.value(forKey: "target") else { return }
        
        //3.3取出action
        //        guard let action = targetObj.value(forKey: "action") as? Selector else { return }
        let action = Selector(("handleNavigationTransition:"))
        
        //4.创建自己的pop手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        //隐藏要push的控制器的tabBar
        viewController.hidesBottomBarWhenPushed = true
        
        super.pushViewController(viewController, animated: true)
    
    }
}
