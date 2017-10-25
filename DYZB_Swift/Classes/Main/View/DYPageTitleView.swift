//
//  DYPageTitleView.swift
//  DYZB_Swift
//
//  Created by qujiahong on 2017/10/23.
//  Copyright © 2017年 瞿嘉洪. All rights reserved.
//

import UIKit
// MARK:- 定义协议
protocol DYPageTitleViewDelegate : class {
    func pageTitleView(titleView : DYPageTitleView, selectedIndex index : Int)
}//selectedIndex外部参数，index内部参数


// MARK:- 定义常量
fileprivate let kScrollLineH : CGFloat = 2
fileprivate let kNormalColor : (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
fileprivate let kSelectCorol : (CGFloat, CGFloat, CGFloat) = (255, 128, 0)

// MARK:- 定义DYPageTitleView类
class DYPageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate var titles : [String]
    fileprivate var currentIndex : Int = 0
    weak var delegate : DYPageTitleViewDelegate?
    //MARK:- 懒加载
    fileprivate lazy var titleLabels : [UILabel] = [UILabel]()
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.isPagingEnabled = false
        scrollView.bounces = false
        return scrollView
    }()
    fileprivate lazy var scrollLine : UIView = {
        let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    
    
    
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]) {
        self.titles = titles;
        super.init(frame: frame)
        
        //设置UI界面
         setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK:- 设置UI界面
extension DYPageTitleView {
    fileprivate func setupUI() {
        //1.添加UIScrollView
        scrollView.frame = bounds
        addSubview(scrollView)
        
        //2.添加title对应的Label
        setupTitleLabels()
        
        //3.设置底线和滚动的滑块
        setupBottomMenuAndScrollLine()
    }
    fileprivate func setupTitleLabels() {
        //0.确定label的一些frame值
        let labelW : CGFloat = frame.width / CGFloat(titles.count)
        let labelH : CGFloat = frame.height - kScrollLineH
        let labelY : CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            //1.创建UILabel
            let label = UILabel()
            
            //2.设置label的属性
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: 16.0)
            label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
            label.textAlignment = .center

            //3.设置label的frame
            let labelX : CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            //4.将label加入到ScrollView中
            scrollView.addSubview(label)
            
            titleLabels.append(label)
            //5.给Label添加收视
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    fileprivate func setupBottomMenuAndScrollLine() {
        //1.添加底线
        let bottomLine = UIView()
        bottomLine.backgroundColor = UIColor.lightGray
        let lineH : CGFloat = 0.5
        bottomLine.frame = CGRect(x: 0, y: frame.height - lineH, width: frame.width, height: lineH)
        addSubview(bottomLine)
        
        //2.添加scrollLine
        //2.1获取第一个label
        guard let firstLabel = titleLabels.first else { return }
        firstLabel.textColor = UIColor(r: kSelectCorol.0, g: kSelectCorol.1, b: kSelectCorol.2)
        
        //2.2设置scrollLine的属性
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

//MARK:- 监听Label的点击事件(事件监听，需要加@objc)
extension DYPageTitleView {
    @objc fileprivate func titleLabelClick(tapGes : UITapGestureRecognizer){
        //1.获取当前Label
        guard let currentLabel = tapGes.view as? UILabel else{ return }
        
        //2.获取之前Label
        let oldLabel = titleLabels[currentIndex];
        
        //3.切换文字颜色
        currentLabel.textColor = UIColor(r: kSelectCorol.0, g: kSelectCorol.1, b: kSelectCorol.2)
        oldLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        //4.保存最新Label的下表值
        currentIndex = currentLabel.tag
        
        //5.滚动条发生滚动
        let scrollLineX = CGFloat(currentIndex) * scrollLine.frame.width
        UIView.animate(withDuration: 0.25) { 
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理 
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
    }
}

//MARK:- 对外暴露的方法
extension DYPageTitleView {
    func setTitleWithProgress(progress: CGFloat, sourceIndex: Int, targetIndex: Int)  {
        //1.取出sourceLabel／targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        //3.处理label颜色的渐变
        //3.1取出颜色变化的范围
        let colorRange = (kSelectCorol.0 - kNormalColor.0, kSelectCorol.1 - kNormalColor.1, kSelectCorol.2 - kNormalColor.2)
        
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectCorol.0 - colorRange.0 * progress, g: kSelectCorol.1 - colorRange.1 * progress, b: kSelectCorol.2 - colorRange.2 * progress)
    
        //4.变化的targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorRange.0 * progress, g: kNormalColor.1 + colorRange.1 * progress, b: kNormalColor.2 + colorRange.2 * progress)
    }
}










