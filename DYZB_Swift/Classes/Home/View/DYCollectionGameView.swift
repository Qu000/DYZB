//
//  DYCollectionGameView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

fileprivate let kGameCellID = "kGameCellID"

private let kEdgeInsetMargin : CGFloat = 10
class DYCollectionGameView: UIView {

    // MARK: - 定义数据属性
    var groups : [DYAnchorGroup]?{
        didSet {
            //移除前两组
            groups?.removeFirst()//颜值
            groups?.removeFirst()//热门
            
            //手动添加  更多
            let moreGroup = DYAnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //刷新
            collectionView.reloadData()
        }
    }
    
    
    // MARK: - 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    // MARK: 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        // 让控件不随着父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册
        collectionView.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    
        // 给collectionView添加内边距
        collectionView.contentInset = UIEdgeInsets(top: 0, left: kEdgeInsetMargin, bottom: 0, right: kEdgeInsetMargin)
    }
}

// MARK:- 提供快速创建的类方法
extension DYCollectionGameView {
    class func recommendGameView() -> DYCollectionGameView {
        return Bundle.main.loadNibNamed("DYCollectionGameView", owner: nil, options: nil)?.first as! DYCollectionGameView
    }
}


// MARK:- 遵守UICollectionView的数据源协议
extension DYCollectionGameView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! DYCollectionGameCell
        cell.group = groups![indexPath.item]
        
        //        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue

        return cell
    }
    
   
    
}

















