//
//  DYHomeViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/23.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//   /coderwhy/DouYuZB/tree/master/DYZB/DYZB

import UIKit
private let kTitleViewH : CGFloat = 40

class DYHomeViewController: UIViewController {
    //MARK:- 懒加载属性(这里用了闭包)
    fileprivate lazy var pageTitleView : DYPageTitleView = {[weak self] in
    
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = DYPageTitleView(frame: titleFrame, titles: titles)
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView : DYPageContentView = {[weak self] in
        //1.确定内容的frame
        let contentH = kScreenH - kStatusBarH - kNavigationBarH - kTitleViewH - kTabBarH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH + kTitleViewH, width: kScreenW, height: contentH)
    
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(DYRecommendViewController())
        childVcs.append(DYGameViewController())
        childVcs.append(DYAmuseViewController())
        childVcs.append(DYFunnyViewController())
        /*
        for _ in 0..<1 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
         */
        
        let contentView = DYPageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        
        contentView.delegate = self
        
        return contentView
    }()
    
    //MARK:- 系统的回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置UI界面
        setupUI()
    }

}
// MARK:-UI界面(swift3里用fileprivate; swift4里是private，取消了fileprivate)
extension DYHomeViewController {
    fileprivate func setupUI() {
        //0.不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        //1.设置导航栏
        setupNavigationBar()
        
        //2.添加TitleView
        view.addSubview(pageTitleView)
        
        //3.添加contentView
        view.addSubview(pageContentView)
        pageContentView.backgroundColor = UIColor.purple
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

// MARK:- 遵守DYPageTitleViewDelegate协议
extension DYHomeViewController : DYPageTitleViewDelegate {
    func pageTitleView(titleView: DYPageTitleView, selectedIndex index: Int) {
//        print(index)
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守DYPageContentViewDelegate协议
extension DYHomeViewController : DYPageContentViewDelegate {
    func pageContentView(contentView: DYPageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
       pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}


