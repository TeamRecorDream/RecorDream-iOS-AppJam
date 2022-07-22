//
//  SearchResultTableViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

final class SearchResultTableViewCell: UITableViewCell {
    @IBOutlet weak var emojiIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var detailButton: UIButton!
    
    func setFilterIcon(data: ListCellDesign) {
        emojiIcon.image = UIImage(named: data.emotion)
        dateLabel.text = data.date
        descriptionLabel.text = data.description
    }
}
