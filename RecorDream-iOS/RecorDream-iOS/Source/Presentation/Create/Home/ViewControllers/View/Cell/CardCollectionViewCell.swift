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
    private let backgroundImage = UIImageView()
    private let mainEmojiImage = UIImageView()
    
    private let dateLabel = UILabel().then {
        $0.font = TypoStyle.subtitle1.font
    }
    
    private let contentLabel = UILabel().then {
        $0.font = TypoStyle.title1.font
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    lazy var cardView = UIView().then {
        $0.addSubviews(backgroundImage, cardStackView)
    }
    
    lazy var cardStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
        $0.addArrangedSubviews(mainEmojiImage, dateLabel, contentLabel)
    }

    lazy var hashtagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
    }
    
    // MARK: - init
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setCardView(
            imageName: Constant.BackgroundColor.IntType(3).title,
            emojiName: Constant.Emotion.IntType(1).title,
            date: "2022/07/13(수)",
            contentText: "안녕하세요 반가워요 잘있어요 다시 만나요")
        setupConstraints()
        setHashtagStackView([2,3], Constant.TextColor.IntType(3).title)
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
            make.leading.equalToSuperview()
            make.top.equalToSuperview()
        }
        
        dateLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(mainEmojiImage.snp.bottom).offset(8)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview()
        }
    }
    
    // MARK: - 카드뷰의 색상 및 label을 결정짓는 함수
    func setCardView(imageName: String, emojiName: String, date: String, contentText: String) {
        backgroundImage.image = UIImage(named: imageName)
        mainEmojiImage.image = UIImage(named: emojiName)
        dateLabel.text = date
        contentLabel.text = contentText
    }
    
    func setHashtagStackView(_ genre:[Int], _ textColor: String){
        // MARK: - 장르가 1개 이상인 경우에만 실행될 함수
        genre.forEach { index in
            let hashtagView = HashtagView()
            hashtagView.setLabelText(text: "#\(Constant.Genre.IntType(index).title)", color: textColor, textTypo: TypoStyle.subtitle3.font)
            hashtagStackView.addArrangedSubview(hashtagView)
            
            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(24)
            }
        }
        cardStackView.addArrangedSubview(hashtagStackView)
        
        hashtagStackView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(contentLabel.snp.bottom).offset(12)
        }
    }
    
    //MARK: - prepare function
    override func prepareForReuse() {
        super.prepareForReuse()
        self.update(plusAlpha: true, updateConst: true)
    }
    
    func update(plusAlpha: Bool , updateConst: Bool){
        self.cardView.alpha = plusAlpha ? 0.6 : 1
    
        if updateConst {
            self.mainEmojiImage.snp.updateConstraints { make in
                make.height.width.equalTo(38)
            }
            contentLabel.font = TypoStyle.subtitle1.font
            dateLabel.font = TypoStyle.subtitle6.font
        } else {
            self.mainEmojiImage.snp.updateConstraints { make in
                make.height.width.equalTo(48)
            }
            contentLabel.font = TypoStyle.title1.font
            dateLabel.font = TypoStyle.subtitle1.font
        }
    }
}
