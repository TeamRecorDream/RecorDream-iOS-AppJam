//
//  MyPageViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/14.
//

import UIKit

class MyPageViewController: UIViewController {
    @IBOutlet var settingView: [UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    private func configureView() {
        settingView.forEach{ view in
            view.makeRoundedWithBorder(radius: CGFloat(8), borderColor: ColorType.gray.color.cgColor)
        }
    }
}
