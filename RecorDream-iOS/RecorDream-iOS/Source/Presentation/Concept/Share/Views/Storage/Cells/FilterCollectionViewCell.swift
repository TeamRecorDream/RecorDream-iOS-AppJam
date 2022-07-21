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
    
    override var isSelected: Bool {
        didSet {
            if isSelected { filterButton?.alpha = 1 }
            else { filterButton?.alpha = 0.35 }
        }
    }
    
    // MARK: - @IBAction Properties
    @IBAction func FilterButtonDidTapped(_ sender: UIButton) {
    }
}
