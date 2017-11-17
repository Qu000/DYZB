//
//  DYRecommenViewModel.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/11/16.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit

class DYRecommenViewModel {

    // MARK: - 懒加载属性
    // 0 1 2-12
    lazy var anchorGroups : [DYAnchorGroup] = [DYAnchorGroup]()
    lazy var cycleModels : [DYCycleModel] = [DYCycleModel]()
    
    fileprivate lazy var bigDataGroup : DYAnchorGroup = DYAnchorGroup()
    fileprivate lazy var prettyGroup : DYAnchorGroup = DYAnchorGroup()

}
// MARK: - 发送网络请求
/*
    NetworkTools.requestData(.get, URLString: "http://httpbin.org/get", parameters: ["name" : "July"]) { (result) in
        print(result)
    }
 */
extension DYRecommenViewModel {
    //请求推荐数据
    func requestData(finishCallback : @escaping () -> ()) {

        //1.paramters
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        //2.创建组Group
        let dGroup = DispatchGroup()
        
        //3.请求第一部分推荐数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime()]) { (result) in
            //3.1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //3.2.根据data的key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //3.3.遍历数组，获取字典，并且将字典转为模型对象
            //3.3.1创建组(创建了一个全局的)
//            let group = DYAnchorGroup()
            
            //3.3.2设置组的属性
            self.bigDataGroup.tag_name = "热门"
            self.bigDataGroup.icon_name = "home_header_hot"
            
            //3.3.3获取主播数据
            for dict in dataArray {
                let anchor = DYAnchorModel(dict: dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.3.4离开组
            dGroup.leave()
        }
        //4.请求第二部分颜值数据
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //4.1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //4.2.根据data的key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //4.3.遍历数组，获取字典，并且将字典转为模型对象
            //4.3.1创建组
            
            //4.3.2设置组的属性
            self.prettyGroup.tag_name = "颜值"
            self.prettyGroup.icon_name = "home_header_phone"
            
            //4.3.3获取主播数据
            for dict in dataArray {
                let anchor = DYAnchorModel(dict: dict)
                self.prettyGroup.anchors.append(anchor)
            }
            //4.3.4离开组
            dGroup.leave()
        }
        //5.请求第2-12三部分游戏数据
        // http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offtset=0&time=1510813624
//        print("\(NSDate.getCurrentTime())")
        dGroup.enter()
        NetworkTools.requestData(.get, URLString: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters) { (result) in
            //5.1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            //5.2.根据data的key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            //5.3.遍历数组，获取字典，并且将字典转为模型对象
            for dict in dataArray{
                let group = DYAnchorGroup(dict: dict)
                self.anchorGroups.append(group)
            }
            //5.4离开组
            dGroup.leave()
        }
        
        //6.所有的数据都获取到之后，进行推荐
        dGroup.notify(queue: DispatchQueue.main) {
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            
            finishCallback()
        }
    }
    
    //请求轮播图数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(.get, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            // 1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            // 2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            // 3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(DYCycleModel(dict: dict))
            }
            
            finishCallback()
        }
    }
}

