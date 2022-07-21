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
        configureCell(genreNumber: 10, emotionNumber: 7)
    }
    
    func configureCell(genreNumber: Int, emotionNumber: Int) {
        self.genreLabel.text = "# \(Constant.Genre.IntType(genreNumber).title)"
        self.genreLabel.backgroundColor = UIColor(named: Constant.BackgroundColor.IntType(emotionNumber).title)
        self.genreLabel.textColor = UIColor(named: Constant.TextColor.IntType(emotionNumber).title)
        self.makeRounded(radius: 2)
    }

}
