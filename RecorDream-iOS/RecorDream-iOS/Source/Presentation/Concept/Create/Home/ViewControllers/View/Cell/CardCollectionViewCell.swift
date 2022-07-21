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
    func setCardView(dream: RecordElement) {
        backgroundImage.image = UIImage(named: Constant.BackgroundColor.IntType(dream.dreamColor).title)
        mainEmojiImage.image = UIImage(named: Constant.Emotion.IntType(dream.emotion).title)
        dateLabel.text = dream.date
        contentLabel.text = dream.title
    }
    
    // MARK: - 장르 뷰 생성하는 함수
    func setHashtagStackView(genres:[Int], textColorNum: Int){
        if genres.count > 0 && !genres.contains(10) {
            genres.forEach { index in
                let hashtagView = HashtagView()
                hashtagView.setLabelText(text: "#\(Constant.Genre.IntType(index).title)", textColorNum: textColorNum, textBackgroundColor: ColorType.white01.name, textTypo: TypoStyle.subtitle3.font)
                hashtagStackView.addArrangedSubview(hashtagView)
                
                hashtagView.snp.makeConstraints { make in
                    make.height.equalTo(24)
                }
            }
        } else if !genres.contains(10) {
            let hashtagView = HashtagView()
            hashtagView.setLabelText(text: "# 아직 설정되지 않았어요.", textColorNum: 0, textBackgroundColor: ColorType.white01.name, textTypo: TypoStyle.subtitle3.font)
            
            hashtagStackView.addArrangedSubview(hashtagView)
            
            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(24)
            }
        } else {
            assert(genres.count >= 0 , "The number of genres must be 0 or more")
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
    
    func update(plusAlpha: Bool , updateConst: Bool) {
        self.cardView.alpha = plusAlpha ? 0.6 : 1
    
        if updateConst {
            self.mainEmojiImage.snp.updateConstraints { make in
                make.width.height.equalTo(38)
            }
            contentLabel.font = TypoStyle.subtitle1.font
            dateLabel.font = TypoStyle.subtitle6.font
        } else {
            self.mainEmojiImage.snp.updateConstraints { make in
                make.width.height.equalTo(48)
            }
            contentLabel.font = TypoStyle.title1.font
            dateLabel.font = TypoStyle.subtitle1.font
        }
    }
}
