//
//  DYGameViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/29.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
private let kEdgMargin : CGFloat = 10
private let kItemW : CGFloat = (kScreenW - 2 * kEdgMargin) / 3
private let kItemH : CGFloat = kItemW * 6 / 5

private let kGameCellID = "kGameCellID"

class DYGameViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // MARK: - 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgMargin, 0, kEdgMargin)
        
        // MARK: - 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // MARK: - collectionView注册cell
        collectionView.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

}
// MARK: - 设置UI界面
extension DYGameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - 遵守数据源协议
extension DYGameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.randomcolor()

        return cell
    }
}




