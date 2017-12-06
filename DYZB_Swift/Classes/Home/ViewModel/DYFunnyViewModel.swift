//
//  DYFunnyViewModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/6.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYFunnyViewModel : DYBaseViewModel{

}
extension DYFunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping() -> ()){
        loadAnchorData(isGropData: false, URLString: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: ["limit" : 30, "offset" : 0], finishedCallback: finishedCallback)
    }
}
