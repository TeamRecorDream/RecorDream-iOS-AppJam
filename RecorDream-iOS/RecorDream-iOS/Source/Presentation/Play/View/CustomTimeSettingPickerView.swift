//
//  CustomTimeSettingPickerView.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/15.
//

import UIKit

class CustomTimeSettingPickerView: UIPickerView {
    
    let meridiems = ["AM", "PM"]
    let hours = Array<Int>(1...12)
    let minutes = Array<Int>(0...59)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureView()
    }
    
    private func configureView(){
        self.dataSource = self
        self.delegate = self
        
    }
}

extension CustomTimeSettingPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 4
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return self.meridiems.count
        case 1:
            return self.hours.count
        case 2:
            return 1
        case 3:
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
    
        func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
            self.subviews[1].backgroundColor = .clear
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width/3, height: 30))
            label.font = row == self.selectedRow(inComponent: component) ? TypoStyle.modal1.font : TypoStyle.modal2.font
            label.textColor = row == self.selectedRow(inComponent: component) ?  ColorType.lightBlue01.color : ColorType.white02.color
            label.textAlignment = .center

            //TODO: - 열거형으로 component 명시적으로 변경하기
            switch component {
            case 0:
                label.text = meridiems[row]
                return label
            case 1:
                label.text = hours[row] < 10 ? "0"+String(hours[row]) : String(hours[row])
                return label
            case 2:
                label.text = ":"
                return label
            case 3:
                label.text = minutes[row] < 10 ? "0"+String(minutes[row]) : String(minutes[row])
                return label
            default:
                return UIView()
            }
        }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.reloadComponent(component)
    }
}
