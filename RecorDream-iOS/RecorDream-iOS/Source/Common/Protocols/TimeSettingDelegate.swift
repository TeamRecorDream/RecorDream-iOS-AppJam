//
//  TimeSettingDelegate.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/19.
//

import Foundation

protocol TimeSettingDelegate: AnyObject {
    func timeSettingDidSelectTime(meridiem: String, hour: String, minute: String)
}
