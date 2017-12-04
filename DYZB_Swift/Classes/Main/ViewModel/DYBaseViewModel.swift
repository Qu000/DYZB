//
//  DYBaseViewModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/2.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYBaseViewModel {
    lazy var anchorGroups : [DYAnchorGroup] = [DYAnchorGroup]()

}


extension DYBaseViewModel {
    func loadAnchorData(URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            //1.对数据进行转换
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(DYAnchorGroup(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
