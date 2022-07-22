//
//  MyPageViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/14.
//

import UIKit

import SnapKit
import Then

class MyPageViewController: BaseViewController {
    @IBOutlet var settingView: [UIView]!
    @IBOutlet weak var dropOutButton: UIButton!
    @IBOutlet weak var dreamAlarmButton: CustomSwitchButton!
    @IBOutlet weak var timeSettingLabel: UILabel!
    @IBOutlet weak var timeSettingButton: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    
    private var headerView = RecordHeaderView()
    private var userInformation: UserInformationModel? {
        didSet{
            DispatchQueue.main.async {
                guard let userInformation = self.userInformation else { return }
                self.userNameTextField.text = userInformation.nickname
                self.emailLabel.text = userInformation.email
                self.dreamAlarmButton.isRequestData = true
                self.dreamAlarmButton.isOn = userInformation.is_active
                self.timeSettingButton.setTitle(userInformation.is_active ? userInformation.time : "", for: .normal)
                self.timeSettingLabel.textColor = userInformation.is_active ? ColorType.white01.color : ColorType.white03.color
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestUserInformation()
        configureView()
    }
    
    //MARK: - Configure
    private func configureView() {
        settingView.forEach { view in
            view.makeRoundedWithBorder(
                radius: CGFloat(8),
                borderColor: ColorType.lightBlue03.color.cgColor
            )
        }
        dropOutButton.setUnderline(at: dropOutButton, state: .normal)
        
        userNameTextField.delegate = self
        configureDreamAlarmButton()
        configureHeaderView()
    }
    
    private func configureDreamAlarmButton(){
        dreamAlarmButton.completion = { [weak self] isOn in
            guard let self = self else { return }
            
            if isOn {
                self.presentTimeSettingView()
            } else {
                self.timeSettingButton.setTitle("", for: .normal)
                self.timeSettingLabel.textColor = ColorType.white03.color
                
            }
            MyPageService.shared.PutUserToggle(isOn: self.dreamAlarmButton.isOn)
        }
    }
    
    private func configureHeaderView(){
        self.view.addSubview(headerView)
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(67.adjustedHeight)
        }
        self.headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "마이페이지")
    }
    
    //MARK: - Action
    private func presentTimeSettingView() {
        let timeSettingViewController = TimeSettingViewController.instanceFromNib()
        timeSettingViewController.modalPresentationStyle = .overFullScreen
        timeSettingViewController.delegate = self
        
        self.present(timeSettingViewController, animated: false){
            timeSettingViewController.showBottomSheet()
        }
    }
    
    @IBAction func didTapTimeSettingButton(_ sender: UIButton) {
        presentTimeSettingView()
    }
    
    @IBAction func didTapNameEditButton(_ sender: UIButton) {
        self.userNameTextField.becomeFirstResponder()
    }
    
}

//MARK: - Extension
extension MyPageViewController: TimeSettingDelegate {
    func timeSettingDidSelectTime(meridiem: String, hour: String, minute: String) {
        let timeString = "\(meridiem) \(hour):\(minute)"
        
        if self.timeSettingButton.titleLabel?.text == "" {
            print("isEmpty")
            MyPageService.shared.postNotice(time: timeString)
        } else {
            print("isNotEmpty")
            MyPageService.shared.putNotice(time: timeString)
        }
        
        timeSettingButton.setTitle(timeString, for: .normal)
        self.timeSettingLabel.textColor = ColorType.white01.color
    }
}

extension MyPageViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let userName = self.userNameTextField.text else { return false }
        if userName.isEmpty && userName.count > 8 {
            return false
        }
        self.userNameTextField.resignFirstResponder()
        
        MyPageService.shared.putUserNickname(nickname: userName)
        return true
    }
}


//MARK: - Network
extension MyPageViewController {
    private func requestUserInformation() {
        MyPageService.shared.getUserInformation(completionHandler: { [weak self] data in
            guard let data = data as? UserInformationModel else { return }
            self?.userInformation = data
        })
    }
}
