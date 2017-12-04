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
fileprivate let kCycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH : CGFloat = 90

fileprivate let kNormalCellID = "kNormalCellID" //normal--Cell
fileprivate let kPrettyCellID = "kPrettyCellID" //pretty--Cell
fileprivate let kHeaderViewID = "kHeaderViewID" //组头
class DYRecommendViewController: DYBaseAnchorViewController {
 
    // MARK: - 懒加载
    fileprivate lazy var recommedVM : DYRecommenViewModel = DYRecommenViewModel()
    
    fileprivate lazy var cycleView : DYRecommedCycleView = {
        let cycleView = DYRecommedCycleView.recommedCycleView()
        
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH+kGameViewH), width: kScreenW, height: kCycleViewH)
        
        return cycleView
    }()
    
    fileprivate lazy var gameView : DYCollectionGameView = {
        
        let gameView = DYCollectionGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
        
    }()
    // MARK: - 系统回调函数
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        //设置UI界面
//        setupUI()
//
//        //网络请求
//        loadData()
//
//
//    }

}
// MARK: - 设置UI界面
extension DYRecommendViewController {
    override func setupUI() {
        //0.先调用super.setupUI()
        super.setupUI()
        
        //1.将UICollectionView添加到控制器View中
        view.addSubview(collectionView)
        
        //2.将cycle加到collection中
        collectionView.addSubview(cycleView)
        
        //4.加入gameView
        collectionView.addSubview(gameView)
        
        //3.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH+kGameViewH, left: 0, bottom: 0, right: 0)
        
    }
}
// MARK: - 网络请求
extension DYRecommendViewController {
    override func loadData(){
       
        //0.给父类中的ViewModel进行赋值
        baseVM = recommedVM
        
        //1.请求推荐数据
        recommedVM.requestData {
            //1.1显示推荐数据
            self.collectionView.reloadData()
            
            var groups = self.recommedVM.anchorGroups
            //1.2移除前两组
            groups.removeFirst()//颜值
            groups.removeFirst()//热门
            
            //1.3手动添加  更多
            let moreGroup = DYAnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            //1.4将数据传递给GameView//self.recommedVM.anchorGroups
            self.gameView.groups = groups
        }
        
        
        //2.请求轮播图数据
        recommedVM.requestCycleData {
            self.cycleView.cycleModel = self.recommedVM.cycleModels
        }
    }
}

extension DYRecommendViewController : UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出DYPretteyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! DYCollectionPrettyCell
            //2.设置数据
            prettyCell.anchor = recommedVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
        }else{
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
}










/*
 // MARK: - 遵守UICollectionView的数据源协议
 extension DYRecommendViewController : UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
 
 func numberOfSections(in collectionView: UICollectionView) -> Int {
 //        return 12
 return recommedVM.anchorGroups.count
 }
 
 func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
 //        if section == 0 {
 //            return 8
 //        }
 //        return 4
 let group = recommedVM.anchorGroups[section]
 
 return group.anchors.count
 
 }
 
 func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
 //1.获取cell
 /*
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
 return cell
 
 
 //1.定义cell
 var cell : UICollectionViewCell!
 
 //2.取出对应cell
 if indexPath.section == 1 {
 cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
 }else{
 cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
 }
 return cell
 */
 /*
 let group = recommedVM.anchorGroups[indexPath.section]
 let anchor = group.anchors[indexPath.item]
 //2.取出对应cell
 if indexPath.section == 1 {
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! DYCollectionPrettyCell
 cell.anchor = anchor
 return cell
 }else{
 let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! DYCollectionNormalCell
 cell.anchor = anchor
 return cell
 }
 */
 let group = recommedVM.anchorGroups[indexPath.section]
 let anchor = group.anchors[indexPath.item]
 //2.定义cell
 var cell : DYCollectionBaseCell!
 
 //3.取出对应cell
 if indexPath.section == 1 {
 cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! DYCollectionPrettyCell
 
 }else{
 cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! DYCollectionNormalCell
 
 }
 //4.将模型赋值给cell
 cell.anchor = anchor
 return cell
 }
 func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
 //1.取出section的HeaderView
 let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! DYCollectionHeaderView
 //2.取出模型
 headerView.group = recommedVM.anchorGroups[indexPath.section]
 
 return headerView
 }
 
 
 func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
 if indexPath.section == 1 {
 return CGSize(width: kItemW, height: kPrettyItemH)
 }
 return CGSize(width: kItemW, height: kNormalItemH)
 }
 
 
 
 }

 */




