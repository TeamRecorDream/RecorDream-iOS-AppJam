//
//  TabBarItem.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/16.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case home
    case plus
    case archieve
}

extension TabBarItem {
    var title: String? {
        switch self {
        case .home:
            return "홈"
        case .plus:
            return "기록하기"
        case .archieve:
            return "보관함"
        }
    }
    var activeIcon: UIImage? {
        switch self {
        case .home:
            return ImageList.icnHome.image
        case .plus:
            return UIImage()
        case .archieve:
            return ImageList.icnStorage.image
        }
    }
    
    func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: activeIcon,
            selectedImage: activeIcon
        )
    }
}
