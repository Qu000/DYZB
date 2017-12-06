//
//  DYAmuseViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/2.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

private let kMenuViewH : CGFloat = 200
class DYAmuseViewController: DYBaseAnchorViewController {

    
    fileprivate lazy var amuseVM : DYAmuseViewModel = DYAmuseViewModel()
    fileprivate lazy var menuView : DYAmuseMenuView = {
        let menuView = DYAmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
    }()
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
//        loadData()
    }

}
// MARK: - 设置UI
extension DYAmuseViewController {
    override func setupUI() {
        super.setupUI()
        
        //添加菜单的view
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsetsMake(kMenuViewH, 0, 0, 0)
       
    }
}

// MARK: - 请求数据
extension DYAmuseViewController {
    override func loadData() {
        //1.给父类中的viewmodel进行赋值
        baseVM = amuseVM
        
        //2.请求数据
        amuseVM.loadAmuseData {
            self.collectionView.reloadData()
            var tempGroup = self.amuseVM.anchorGroups
            tempGroup.removeFirst()
            self.menuView.groups = tempGroup
        }
    }
}












//fileprivate let kItemMargin : CGFloat = 10
//fileprivate let kItemW = (kScreenW - 3 * kItemMargin) / 2
//fileprivate let kNormalItemH = kItemW * 3 / 4
//fileprivate let kPrettyItemH = kItemW * 4 / 3
//fileprivate let kHeaderViewH : CGFloat = 50
//
//fileprivate let kNormalCellID = "kNormalCellID" //normal--Cell
//fileprivate let kPrettyCellID = "kPrettyCellID" //pretty--Cell
//fileprivate let kHeaderViewID = "kHeaderViewID" //组头


// MARK: - 设置UI界面
//extension DYAmuseViewController {
//    fileprivate func setupUI() {
//        view.addSubview(collectionView)
//    }
//}


/*
 // MARK: - 懒加载属性
 fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
 //1.创建布局
 let layout = UICollectionViewFlowLayout()
 layout.itemSize = CGSize(width: kItemW, height: kNormalItemH)
 layout.minimumLineSpacing = 0//行间距
 layout.minimumInteritemSpacing = kItemMargin//item的间距
 layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)//组头
 layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)//设置组的内边距和margin
 
 //2.创建UICollectionView
 let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
 
 collectionView.backgroundColor = UIColor.white
 collectionView.dataSource = self
 collectionView.delegate = self
 collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
 
 collectionView.register(UINib(nibName: "DYCollectionNormalCell",bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
 
 collectionView.register(UINib(nibName: "DYCollectionPrettyCell",bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
 
 collectionView.register(UINib(nibName: "DYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
 
 return collectionView
 }()*/




/*
// MARK: - 遵守collectionView的数据源协议与代理
extension DYAmuseViewController : UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return amuseVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return amuseVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! DYCollectionNormalCell
        
        //2.给cell设置数据
        cell.anchor = amuseVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! DYCollectionHeaderView
        //2.设置数据
        headerView.group = amuseVM.anchorGroups[indexPath.section]
        //3.
        
        return headerView
    }
}
*/

















