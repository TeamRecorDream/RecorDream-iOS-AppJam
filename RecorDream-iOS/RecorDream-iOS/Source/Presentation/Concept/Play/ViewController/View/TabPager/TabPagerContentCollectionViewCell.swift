//
//  TabPagerContentCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit

class TabPagerContentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TabPagerCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "TabPagerContentCollectionViewCell", bundle: nil)
    }
    var labelSize: CGSize = CGSize(width: 0, height: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(isHidden: Bool) {
    }
}
