//
//  FilterCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

final class FilterCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    @IBOutlet weak var filterButton: UIButton!
    
    func setFilterIcon(data: FilterIconList) {
        filterButton.imageView?.image = UIImage(named: data.emotion)
    }
}
