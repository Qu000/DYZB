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
        
            //默认滚动到中间的某个位置//防止用户往前滚时，没有东西
            let indexPath = NSIndexPath(item: (cycleModel?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
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

        return (cycleModel?.count ?? 0) * 10000//为了无限轮播
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! DYCollectionCycleCell
//        cell.cycleModel = cycleModel![indexPath.item]//不轮播的时候
        cell.cycleModel = cycleModel![indexPath.item % cycleModel!.count]//为了做轮播的循环处理
        
        
//        cell.backgroundColor = indexPath.item % 2 == 0 ? UIColor.red : UIColor.blue
        
        return cell
    }
}

// MARK: - 遵守UICollectionView的代理协议
extension DYRecommedCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width / 2
        
        //2.计算pageControl的currentIndex
//        pageControll.currentPage = Int(offsetX / scrollView.bounds.width)//不轮播时
        pageControll.currentPage = Int(offsetX / scrollView.bounds.width) % (cycleModel?.count ?? 1)
        
    }
}















