//
//  CustomTimeSettingPickerView.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/15.
//
// 마이페이지 시간 설정 UIPicker Custom

import UIKit

//시간 설정 PickerView 구성 요소
enum Time: Int, CaseIterable {
    case meridiem = 0
    case hour = 1
    case colon = 2
    case minute = 3
    
    var order: Int {
        return self.rawValue
    }
}

class CustomTimeSettingPickerView: UIPickerView {
    
    private let meridiems = ["AM", "PM"]
    private let hours = Array<Int>(1...12)
    private let minutes = Array<Int>(0...59)
    
    var selectedMeridiem = "AM"
    var selectedHour = 1
    var selectedMinute = 0
    
    //MARK: - Initialize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    //MARK: - Configure
    
    private func configureView(){
        self.dataSource = self
        self.delegate = self
    }
}

//MARK: - Extension

extension CustomTimeSettingPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return Time.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case Time.meridiem.order:
            return self.meridiems.count
        case Time.hour.order:
            return self.hours.count
        case Time.colon.order:
            return 1
        case Time.minute.order:
            return self.minutes.count
        default:
            return 0
        }
    }
}

extension CustomTimeSettingPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 53
    }
    
    //PickerView의 각 Component마다 넣어 줄 UIView 구성
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        self.subviews[1].backgroundColor = .clear
        
        let label = UILabel(
            frame: CGRect(
                x: 0,
                y: 0,
                width: self.frame.width/3,
                height: 30)
        )
        label.font = row == self.selectedRow(inComponent: component) ? TypoStyle.modal1.font : TypoStyle.modal2.font
        label.textColor = row == self.selectedRow(inComponent: component) ?  ColorType.lightBlue01.color : ColorType.white02.color
        label.textAlignment = .center
        
        switch component {
        case Time.meridiem.order:
            label.text = meridiems[row]
            return label
        case Time.hour.order:
            label.text = hours[row] < 10 ? "0"+String(hours[row]) : String(hours[row])
            return label
        case Time.colon.order:
            label.text = ":"
            return label
        case Time.minute.order:
            label.text = minutes[row] < 10 ? "0"+String(minutes[row]) : String(minutes[row])
            return label
        default:
            return UIView()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case Time.meridiem.order:
            self.selectedMeridiem = meridiems[row]
            break
        case Time.hour.order:
            self.selectedHour = hours[row]
            break
        case Time.minute.order:
            self.selectedMinute = minutes[row]
        default:
            break
        }
        self.reloadComponent(component)
    }
}
