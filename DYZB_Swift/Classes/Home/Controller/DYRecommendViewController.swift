//
//  DYRecommendViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/25.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let kNormalCellID = "kNormalCellID" //normal--Cell
fileprivate let kPrettyCellID = "kPrettyCellID" //pretty--Cell
fileprivate let kHeaderViewID = "kHeaderViewID" //组头
class DYRecommendViewController: UIViewController {
 
    // MARK: - 懒加载
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
        /*
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellID)
        */
            
        /*
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
         */
        return collectionView
    }()

    
    // MARK: - 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置UI界面
        setupUI()

        //网络请求
        loadData()

        
    }

}
// MARK: - 设置UI界面
extension DYRecommendViewController {
    fileprivate func setupUI() {
        //1.将UICollectionView添加到控制器View中
        view.addSubview(collectionView)
    }
}
// MARK: - 网络请求
extension DYRecommendViewController {
    fileprivate func loadData(){
        NetworkTools.requestData(.get, URLString: "http://httpbin.org/get", parameters: ["name" : "July"]) { (result) in
                print(result)
            }
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension DYRecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        }
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        /*
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        return cell
         */
        //1.定义cell
        var cell : UICollectionViewCell!
        
        //2.取出对应cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
        }else{
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        return headerView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    
    
}


