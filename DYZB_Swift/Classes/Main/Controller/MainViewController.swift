//
//  MainViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/23.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let vc = UIViewController()
//        vc.view.backgroundColor = UIColor.blue
//        addChildViewController(vc)
        
        addChildVc(storyName: "Home")
        addChildVc(storyName: "Live")
        addChildVc(storyName: "Follow")
        addChildVc(storyName: "Profile")
        
    }
    private func addChildVc(storyName : String){
        //1.通过storyBoard获取控制器
        let childVc = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        //2.将childVc作为自控制器
        addChildViewController(childVc)
    }

}
