//
//  ListCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

final class ListCollectionViewCell: UICollectionViewCell {
    // MARK: - @IBOutlet Properties
    @IBOutlet weak var emojiIcon: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var hashTagView: HashtagView!
    
    // MARK: - @IBAction Properties
    @IBAction func touchUpToDetailButton(_ sender: UIButton) {
        // TODO: - 상세보기 뷰로 연결
    }

}
