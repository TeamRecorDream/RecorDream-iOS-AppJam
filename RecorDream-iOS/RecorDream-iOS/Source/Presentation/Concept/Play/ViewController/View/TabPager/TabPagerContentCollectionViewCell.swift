//
//  TabPagerContentCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit

class TabPagerContentCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var audioPlayView: UIView!
    @IBOutlet weak var middleBarView: UIView!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var audioPlayStackViewHeight: NSLayoutConstraint!
    static let identifier = "TabPagerCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "TabPagerContentCollectionViewCell", bundle: nil)
    }
    var labelSize: CGSize = CGSize(width: 0, height: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(isHidden: Bool) {
        audioPlayStackViewHeight.constant = isHidden ? 0 : self.frame.height / 5
        audioPlayView.isHidden = isHidden
        middleBarView.isHidden = isHidden
    }
}
