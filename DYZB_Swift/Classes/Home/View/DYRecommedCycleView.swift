//
//  DYRecommedCycleView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/17.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
fileprivate let kCycleCellID = "kCycleCellID"

class DYRecommedCycleView: UIView {
    // MARK: - 定义属性
    var cycleModel : [DYCycleModel]? {
        didSet {
            //刷新
            collectionView.reloadData()
            
            //设置pageControl的个数
            pageControll.numberOfPages = cycleModel?.count ?? 0
        
        }
    }
    

    // MARK: - 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControll: UIPageControl!
    // MARK: - 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing()
        
        //注册cell
        collectionView.register(UINib(nibName: "DYCollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
  
    }
    // MARK: - 只有在layoutSubviews()里拿到的frame才是最正确的
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //设置collectionView的layout
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.isPagingEnabled = true
        
    }

}
// MARK: - 提供一个快速创建view的类方法
extension DYRecommedCycleView {
    class func recommedCycleView() -> DYRecommedCycleView {
        return Bundle.main.loadNibNamed("DYRecommedCycleView", owner: nil, options: nil)?.first as! DYRecommedCycleView
    }
}

// MARK: - 遵守UICollectionView的数据源协议
extension DYRecommedCycleView : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return cycleModel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! DYCollectionCycleCell
        cell.cycleModel = cycleModel![indexPath.item]
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}


















