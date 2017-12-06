//
//  DYAmuseMenuView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

private let kMenuCellID = "kMenuCellID"

class DYAmuseMenuView: UIView {

    // MARK: - 定义属性
    var groups : [DYAnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - 控件属性
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "DYAmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = collectionView.bounds.size
    }
}
extension DYAmuseMenuView {
    class func amuseMenuView() -> DYAmuseMenuView {
        return Bundle.main.loadNibNamed("DYAmuseMenuView", owner: nil, options: nil)?.first as! DYAmuseMenuView
    }
}


extension DYAmuseMenuView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if groups == nil { return 0 }
        let pageNumber = (groups!.count - 1) / 8 + 1
        
        pageControl.numberOfPages = pageNumber
        return pageNumber
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! DYAmuseMenuViewCell
        
        setupCellDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    private func setupCellDataWithCell(cell : DYAmuseMenuViewCell, indexPath : IndexPath) {
        //0.  0页： 0 - 7 / 1页： 8 - 15 / 1页： 16 - 23
        //1. 取出起始位置&终点位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        //2. 判断越界
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //3. 取出数据，并且赋值给cell
        cell.groups = Array(groups![startIndex...endIndex])
    
    }
}

extension DYAmuseMenuView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.currentPage = Int((scrollView.contentOffset.x / scrollView.bounds.width))
    }
}














