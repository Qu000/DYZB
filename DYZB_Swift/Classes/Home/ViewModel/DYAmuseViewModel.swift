//
//  DYAmuseViewModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/2.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYAmuseViewModel {

    lazy var anchorGroups : [DYAnchorGroup] = [DYAnchorGroup]()
}

extension DYAmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotRoom/2", parameters: nil) { (result) in
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
