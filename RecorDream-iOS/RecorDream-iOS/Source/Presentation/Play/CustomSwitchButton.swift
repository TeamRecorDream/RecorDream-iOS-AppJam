//
//  CustomSwitchButton.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/14.
//

import UIKit

class CustomSwitchButton: UIButton {
    private var barView: UIView?
    private var circleView: UIView?
    private var circleVerticalMargin: CGFloat = 3
    private var circleHorizontalMargin: CGFloat = 4
    
    let onTintColor = ColorType.subPurple01.color
    let offTintColor = ColorType.black01.color
    let animationDuration: TimeInterval = 0.3
    let circleSize: CGFloat = 14
    var circleCenter: CGFloat = 0
    
    var isOn: Bool = false {
        didSet {
            self.barView?.backgroundColor = isOn ? onTintColor : offTintColor
            self.circleCenter = frame.width
            self.isSelected = isOn
            self.circleCenter = isOn ? frame.width - (circleHorizontalMargin + (circleSize/2)) : circleHorizontalMargin + (circleSize/2)
            //나는 지금 원의 중심의 x값을 할당하고 있다!!!!
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureButton(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configureButton(frame: frame)
    }
    
    private func configureButton(frame: CGRect){
        print("frame.height: \(frame.height)")
        print("frame.width : \(frame.width)")
        print("frame.width - circleHorizontalMargin \(frame.width - circleHorizontalMargin)")
        
        barView = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        
        barView?.backgroundColor = ColorType.black01.color
        barView?.layer.cornerRadius = frame.height / 2
        barView?.layer.masksToBounds = true
        
        guard let barView = barView else {return}
        self.addSubview(barView)
        
        circleView = UIView(frame: CGRect(x: circleHorizontalMargin + (circleSize/2), y: circleVerticalMargin, width: circleSize, height: circleSize))
        circleView?.backgroundColor = ColorType.white01.color
        circleView?.layer.cornerRadius = circleSize / 2
        circleView?.layer.masksToBounds = true
        
        guard let circleView = circleView else {return}
        self.addSubview(circleView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isOn.toggle()
        configureAnimation()
        if isOn {
            print("on")
        }else {
            print("off")
        }
    }
    
    private func configureAnimation(){
        UIView.animate(withDuration: animationDuration, animations: {[weak self] in
            guard let self = self else {return}
            self.circleView?.center.x = self.circleCenter
        }, completion: { [weak self] _ in
            //guard let circleView = self.circleView else {return}
            //self.circleView?.center.x = self.circleCenter
        })
    }
}
