//
//  EmotionCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/18.
//  나의 감정, 꿈의 색상 부분에 사용될 collectionViewCell

import UIKit

import SnapKit
import Then

class RecordBarCollectionViewCell: UICollectionViewCell {
    var recordBarImageView = UIImageView().then {
        $0.alpha = 0.35
    }
    
    let recordBarView = UIView()
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
    }
    
//    override var isSelected: Bool{
//        didSet {
//            if isSelected {
//                recordBarImageView.alpha = 1
//            } else {
//                recordBarImageView.alpha = 0.35
//            }
//        }
//    }
//
    override var isSelected: Bool {
        willSet {
            self.setSelected(newValue)
        }
    }
    
    private func setSelected(_ selected: Bool) {
        if selected {
            recordBarImageView.alpha = 1
        } else {
            recordBarImageView.alpha = 0.35
        }
    }
    
    override func prepareForReuse() {
//        super.prepareForReuse()
        self.isSelected = false
        print("살려주세요")
    }
    
    private func setupView() {
        recordBarView.addSubview(recordBarImageView)
        contentView.addSubview(recordBarView)
    }
    
    private func setupConstraints() {
        recordBarView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        recordBarImageView.snp.makeConstraints { make in
            make.width.equalTo(36.adjustedWidth)
            make.height.equalTo(36.adjustedHeight)
            make.centerX.centerY.equalToSuperview()
        }
    }
    
    func setRecordBarImage(imageName: String) {
        recordBarImageView.image = UIImage(named: imageName)
    }
    
    func updateRecordBarImage(reset: Bool ) {
        self.recordBarImageView.alpha = reset ? 0.35 : 1
    }
    
    func testFunc() {
        self.recordBarImageView.alpha = 1
        print("아 슈밸 왜안돼 ㅠㅠ")
    }
}
