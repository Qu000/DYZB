//
//  DYFunnyViewController.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

private let kTopMargin : CGFloat = 8
class DYFunnyViewController: DYBaseAnchorViewController {
    // MARK: - 懒加载 ViewModel对象
    fileprivate lazy var funnyVM : DYFunnyViewModel = DYFunnyViewModel()
}
extension DYFunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.headerReferenceSize = CGSize.zero
        collectionView.contentInset = UIEdgeInsets(top: kTopMargin, left: 0, bottom: 0, right: 0)
    }
}
extension DYFunnyViewController {
    override func loadData() {
        //1. 给父类中的viewModel进行赋值
        baseVM = funnyVM
        
        //2. 请求数据
        funnyVM.loadFunnyData {
            self.collectionView.reloadData()
            
            
            //请求完成
            self.loaddataFinished()
        }
    }
}



