//
//  HeaderViewDelegate.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/17.
//

import UIKit

protocol NavigationBarDelegate {
    // MARK: - 기록하기 / 상세보기 뷰에서 쓰일 custom navigation bar에 사용되는 프로토콜
    func navigationBackButtonDidTap()
    func navigationMoreButtonDidTap()
}
