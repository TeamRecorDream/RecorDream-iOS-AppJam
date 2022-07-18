//
//  TimeSettingViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/15.
//

import UIKit

class TimeSettingViewController: BaseViewController {
    @IBOutlet weak var timeSettingView: UIView!
    @IBOutlet weak var timeSettingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var modalIndicatorView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView(){
        self.timeSettingViewHeight.constant = 0
        self.modalIndicatorView.makeRounded(radius: 4)
        self.timeSettingView.makeRoundedSpecificCorner(
            corners: [.topLeft, .topRight],
            cornerRadius: 12
        )
    }
    
    //MARK: - Action
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let touch = touches.first,
        touch.view == self.view {
            self.hideBottomSheet()
        }
    }
}

//MARK: - BottomSheet Animation

extension TimeSettingViewController {
    func showBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.timeSettingViewHeight.constant = 272
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.timeSettingViewHeight.constant = 0
            self.view.layoutIfNeeded()
        }completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
