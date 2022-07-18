//
//  CustomSwitchButton.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/14.
//
// 마이페이지 꿈 푸시 알림 토글 버튼 UISwitch custom

import UIKit

class CustomSwitchButton: UIButton {
    //MARK: - UIView
    
    private var barView: UIView?
    private var circleView: UIView?
    
    //MARK: - Properties
    
    private let onTintColor = ColorType.subPurple01.color
    private let offTintColor = ColorType.black01.color
    private let animationDuration: TimeInterval = 0.3
    private let circleSize: CGFloat = 14
    private var circleVerticalMargin: CGFloat = 3
    private var circleHorizontalMargin: CGFloat = 4
    private var circleCenter: CGFloat = 0
    private var isOn: Bool = false {
        didSet {
            self.barView?.backgroundColor = isOn ? onTintColor : offTintColor
            self.circleCenter = isOn ? frame.width - (circleHorizontalMargin + (circleSize/2)) : circleHorizontalMargin + (circleSize/2)
        }
    }
    var completion: (() -> Void) = {}
    
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.configureButton(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.configureButton(frame: frame)
    }
    
    //MARK: - Configure
    
    private func configureButton(frame: CGRect){
        barView = {
            let view = UIView(
                frame: CGRect(
                    x: 0,
                    y: 0,
                    width: frame.width,
                    height: frame.height
                )
            )
            view.backgroundColor = ColorType.black01.color
            view.layer.cornerRadius = frame.height / 2
            view.layer.masksToBounds = true
            return view
        }()
        
        circleView = {
            let view = UIView(
                frame: CGRect(
                    x: circleHorizontalMargin + (circleSize/2),
                    y: circleVerticalMargin,
                    width: circleSize,
                    height: circleSize
                )
            )
            view.backgroundColor = ColorType.white01.color
            view.layer.cornerRadius = circleSize / 2
            view.layer.masksToBounds = true
            
            return view
        }()
        
        guard let circleView = circleView else {return}
        guard let barView = barView else {return}
        self.addSubviews(barView, circleView)
    }
    
    private func configureAnimation(){
        UIView.animate(
            withDuration: animationDuration,
            animations: {[weak self] in
                guard let self = self else {return}
                self.circleView?.center.x = self.circleCenter
            }
        )
    }
    
    //MARK: - Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        isOn.toggle()
        configureAnimation()
        self.completion()
    }
}
