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

private let kHeaderViewH : CGFloat = 50

private let kGameCellID = "kGameCellID"
private let kGameHeaderViewID = "kGameHeaderViewID"
class DYGameViewController: UIViewController {

    // MARK: - 懒加载属性
    fileprivate lazy var gameVM : DYGameViewModel = DYGameViewModel()
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        
        // MARK: - 创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsetsMake(0, kEdgMargin, 0, kEdgMargin)
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        
        // MARK: - 创建collectionView
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        
        // MARK: - collectionView注册cell
        collectionView.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        // MARK: - collectionView注册头部
        collectionView.register(UINib(nibName: "DYCollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kGameHeaderViewID)
        
        collectionView.backgroundColor = UIColor.white
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.dataSource = self
        return collectionView
    }()
    
    // MARK: - 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData()
    }

}
// MARK: - 设置UI界面
extension DYGameViewController {
    fileprivate func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - 请求数据
extension DYGameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            self.collectionView.reloadData()
        }
    }
}

// MARK: - 遵守数据源协议&代理
extension DYGameViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gameVM.games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! DYCollectionGameCell
        
        let gameModel = gameVM.games[indexPath.item]
        cell.baseGame = gameModel
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kGameHeaderViewID, for: indexPath) as! DYCollectionHeaderView
        
        //1.设置headerView的属性
        headerView.titleLab.text = "全部"
        headerView.iconImg.image = UIImage(named: "Img_orange")
        headerView.moreBtn.isHidden = true
        return headerView
    }
}




