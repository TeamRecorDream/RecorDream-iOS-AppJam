//
//  RecordDetailBottomSheetViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/21.
//

import UIKit

class RecordDetailBottomSheetViewController: BaseViewController {
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Configure
    private func configureView(){
        self.bottomSheetHeight.constant = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, self.view == touch.view {
            hideBottomSheet()
        }
    }
}

//MARK: - BottomSheet Animation
extension RecordDetailBottomSheetViewController {
    func showBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.bottomSheetHeight.constant = self.view.frame.height / 3
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.bottomSheetHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: {[weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }
    }
}
