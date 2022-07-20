//
//  GenreCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var genreLabel: UILabel!
    
    static let identifier = "GenreCollectionViewCell"
    static func nib() -> UINib {
        UINib(nibName: "GenreCollectionViewCell", bundle: nil)
    }
    var labelSize: CGSize = CGSize(width: 0, height: 0)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        labelSize = self.genreLabel.intrinsicContentSize
        configureCell(Constant.Genre.IntType(10).title)
    }
    
    func configureCell(_ genre: String) {
        self.genreLabel.text = "# \(genre)"
        self.makeRounded(radius: 2)
    }

}
