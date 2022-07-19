//
//  TimeSettingViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/15.
//

import UIKit

protocol TimeSettingViewControllerDelegate: AnyObject {
    func passTime(meridiem: String, hour: String, minute: String)
}

class TimeSettingViewController: BaseViewController {
    @IBOutlet weak var timeSettingView: UIView!
    @IBOutlet weak var timeSettingViewHeight: NSLayoutConstraint!
    @IBOutlet weak var modalIndicatorView: UIView!
    @IBOutlet weak var timeSettingPickerView: CustomTimeSettingPickerView!
    
    //MARK: - Properties
    weak var delegate: TimeSettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    //MARK: - Configure
    private func configureView(){
        self.timeSettingViewHeight.constant = 0
        self.modalIndicatorView.makeRounded(radius: 4)
        
        self.timeSettingView.clipsToBounds = true
        self.timeSettingView.layer.cornerRadius = 12
        self.timeSettingView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
    }
    
    //MARK: - Action
    @IBAction func didTapTimeSaveButton(_ sender: UIButton) {
        let selectedMeridiem = self.timeSettingPickerView.selectedMeridiem
        let selectedHour = self.timeSettingPickerView.selectedHour
        let selectedMinute = self.timeSettingPickerView.selectedMinute
        self.delegate?.passTime(meridiem: selectedMeridiem, hour: selectedHour, minute: selectedMinute)
        
        hideBottomSheet()
    }
}

//MARK: - BottomSheet Animation
extension TimeSettingViewController {
    func showBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.timeSettingViewHeight.constant = self.view.frame.height / 3
            self.view.layoutIfNeeded()
        }
    }
    
    private func hideBottomSheet(){
        UIView.animate(withDuration: 0.3){
            self.timeSettingViewHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: {[weak self] _ in
            guard let self = self else { return }
            self.dismiss(animated: false)
        }
    }
}
