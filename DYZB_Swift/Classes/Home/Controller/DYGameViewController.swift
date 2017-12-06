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

private let kGameViewH : CGFloat = 90

private let kGameCellID = "kGameCellID"
private let kGameHeaderViewID = "kGameHeaderViewID"
class DYGameViewController: DYBaseViewController {

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
    
    fileprivate lazy var topHeaderview : DYCollectionHeaderView = {
        let headerView = DYCollectionHeaderView.collectionHeaderView()
    
        headerView.iconImg.image = UIImage(named: "Img_orange")
        headerView.titleLab.text = "常用"
        headerView.moreBtn.isHidden = true
        headerView.frame = CGRect(x: 0, y: -(kHeaderViewH + kGameViewH), width: kScreenW, height: kHeaderViewH)
        return headerView
    }()
    
    fileprivate lazy var gameView : DYCollectionGameView = {
        let gameView = DYCollectionGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        
        return gameView
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
     override func setupUI() {
        //0.给ContentView进行赋值
        contentView = collectionView
        
        //1.添加collectionView
        view.addSubview(collectionView)
        
        //2.添加顶部的topView
        collectionView.addSubview(topHeaderview)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsetsMake(kHeaderViewH + kGameViewH, 0, 0, 0)
        
        //4.将常用游戏的view添加到collectionView中
        collectionView.addSubview(gameView)
        
        super.setupUI()
    }
}

// MARK: - 请求数据
extension DYGameViewController {
    fileprivate func loadData() {
        gameVM.loadAllGameData {
            //1.展示全部游戏
            self.collectionView.reloadData()
            
            //2.展示常用游戏
//            var tempArray = [DYBaseGameModel]()
//            for i in 0..<10 {
//                tempArray.append(self.gameVM.games[i])
//            }

            self.gameView.groups = Array(self.gameVM.games[0..<10])
            
            //请求完成
            self.loaddataFinished()
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




