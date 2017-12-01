//
//  DYGameViewModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/12/1.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYGameViewModel {
    lazy var games : [DYGameModel] = [DYGameModel]()
}

extension DYGameViewModel {
    func loadAllGameData(finnishedCallbak : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            //http://capi.douyucdn.cn/api/v1/getColumnDetail?shortName=game
            
            //1.获取到数据(将Any转为字典)
            guard let resultDict = result as? [String : Any] else { return }
            
            //1.1根据 data 这个key，获取value
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for dict in dataArray {
                self.games.append(DYGameModel(dict: dict))
            }
            
            //3.完成回调
            finnishedCallbak()
        }
    }
}
