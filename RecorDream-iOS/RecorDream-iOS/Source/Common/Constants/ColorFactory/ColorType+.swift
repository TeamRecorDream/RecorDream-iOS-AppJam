//
//  Color.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

extension ColorType {
    var color: UIColor {
        guard let color = UIColor(named: self.name) else { return UIColor() }
        return color
    }
}
