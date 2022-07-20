//
//  TabPagerTitleCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit

class TabPagerTitleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    static let identifier = "TabPagerCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "TabPagerTitleCollectionViewCell", bundle: nil)
    }
    var labelSize: CGSize = CGSize(width: 0, height: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ title: String) {
        self.titleLabel.text = title
    }
}
