//
//  CardCollectionViewCell.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.

//  Home View에 있는 카드에 들어갈 cell

import UIKit
import SnapKit
import Then

class CardCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties
    static let identifier = "CardCollectionViewCell"
    
    let backgroundImage = UIImageView()
    let mainEmojiImage = UIImageView()
    let hashtagView = HashtagView()
    
    let dateLabel = UILabel().then {
        $0.font = TypoStyle.subtitle1.font
    }
    
    let contentLabel = UILabel().then {
        $0.font = TypoStyle.title1.font
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    lazy var cardView = UIView().then {
        $0.addSubviews(backgroundImage, cardStackView)
    }
//
//    lazy var hashtagStakView = UIStackView().then {
//        $0.axis = .horizontal
//        $0.addArrangedSubviews(hashtagView)
//    }
    
    lazy var cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
        $0.addArrangedSubviews(mainEmojiImage, dateLabel, contentLabel, hashtagView)
    }
    
    // MARK: - init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setCardView(ImageList.mainCardColorGreen.name, ImageList.mainEmojiJoy.name, "2022/07/13(수)", "윤정 시하 사랑해 안녕 지금은 새벽 세시어쩌구 저쩌구 . .졸려 죽을지경임  ~") // TODO: - cell 불러오는 곳에서 수정하기
        setupConstraints()
    }
    
    func setupView() {
        contentView.addSubview(cardView)
    }
    
    func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        cardStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalToSuperview().offset(22)
            make.trailing.equalToSuperview().inset(22)
        }
        
        cardStackView.setCustomSpacing(12, after: contentLabel)
        
        mainEmojiImage.snp.makeConstraints { make in
            make.width.height.equalTo(48)
            make.leading.equalToSuperview().offset(2)
            make.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.top.equalTo(mainEmojiImage.snp.bottom).offset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
        }
        
        hashtagView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(2)
            make.height.equalTo(24)
        }
    }
    
    func setCardView(_ imageName: String, _ emojiName: String, _ date: String, _ contentText: String) {
        backgroundImage.image = UIImage(named: imageName)
        mainEmojiImage.image = UIImage(named: emojiName)
        dateLabel.text = date
        contentLabel.text = contentText
    }
}
