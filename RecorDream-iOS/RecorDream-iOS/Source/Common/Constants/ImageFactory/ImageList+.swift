//
//  ImageList+.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

extension ImageList {
    var image: UIImage {
        guard let image = UIImage(named: self.name) else { return UIImage() }
        return image
    }
}
