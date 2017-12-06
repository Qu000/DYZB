//
//  DYAmuseMenuViewCell.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

private let kGameCellID = "kGameCellID"

class DYAmuseMenuViewCell: UICollectionViewCell {
    // MARK: - 数组模型
    var groups : [DYAnchorGroup]?{
        didSet{
            collectionView.reloadData()
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - 从xib加载 
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "DYCollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let itemW = collectionView.bounds.width / 4
        let itemH = collectionView.bounds.height / 2
        layout.itemSize = CGSize(width: itemW, height: itemH)
    }

}
extension DYAmuseMenuViewCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! DYCollectionGameCell
        
        cell.baseGame = groups![indexPath.item]
        cell.clipsToBounds = true
        
        return cell
    }
}
