//
//  MyPageViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/14.
//

import UIKit

class MyPageViewController: BaseViewController {
    @IBOutlet var settingView: [UIView]!
    @IBOutlet weak var dropOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        settingView.forEach{ view in
            view.makeRoundedWithBorder(radius: CGFloat(8), borderColor: ColorType.lightBlue03.color.cgColor)
        }
        dropOutButton.setUnderLine()
    }
}
