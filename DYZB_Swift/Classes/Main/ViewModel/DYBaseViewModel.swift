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
    func loadAnchorData(isGropData : Bool, URLString : String, parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: URLString, parameters: parameters) { (result) in
            //1.对数据进行转换
            guard let resultDict = result as? [String : Any] else { return }
            
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.判断是否为分组数据
            if isGropData {
                //2.1遍历数组中的字典
                for dict in dataArray {
                    self.anchorGroups.append(DYAnchorGroup(dict: dict))
                }
            } else {
                //2.1创建一个组
                let group = DYAnchorGroup()
                
                //2.2遍历
                for dict in dataArray {
                    group.anchors.append(DYAnchorModel(dict: dict))
                }
                
                //2.3将group添加到anchorGroups
                self.anchorGroups.append(group)
            }
            
            
            //3.完成回调
            finishedCallback()
        }
    }
}
