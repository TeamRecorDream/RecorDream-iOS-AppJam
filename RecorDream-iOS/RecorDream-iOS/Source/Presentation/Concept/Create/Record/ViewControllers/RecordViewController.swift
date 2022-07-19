//
//  RecordViewController.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/17.
//

import UIKit

import HeeKit
import SnapKit
import Then

enum CollectionViewConst {
    static let itemSize = CGSize(width: 45.adjustedWidth, height: 60.adjustedHeight)
    static let itemSpacing = 20.0

    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top:0, left: 10, bottom: 0, right: 10)
    }
}

class RecordViewController: BaseViewController {
    // MARK: - Properties
    private let headerView = RecordHeaderView()
    private let dateView = RecordDateBarView()
    private let voiceView = RecordVoiceBarView()
    private let scrollView = UIScrollView()
    private let contentsView = UIView()
    private let titleTextField = UITextField().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor) // TODO: - light_blue03 으로 변경해야함
        $0.placeholder = "꿈의 제목을 남겨주세요."
        $0.addLeftPadding(width: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "꿈의 제목을 남겨주세요.", attributes: [NSAttributedString.Key.foregroundColor : ColorType.white02.color])
    }
    
    private let contentLable = UILabel().then {
        $0.text = "꿈을 기록해주세요."
        $0.font = TypoStyle.title2.font
        $0.textColor = ColorType.white02.color
    }
    private lazy var contentTextView = UITextView().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor) // TODO: - light_blue03 으로 변경해야함
        $0.textContainerInset = UIEdgeInsets.init(top: 18, left: 16, bottom: 18, right: 16)
    }
    
    private let emotionLabel = UILabel().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.text = "나의 감정"
    }
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CollectionViewConst.itemSize
        $0.sectionInset = CollectionViewConst.collectionViewContentInset
    }

    private lazy var emotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier)
        $0.isPagingEnabled = false
        $0.decelerationRate = .fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
    }
    
    private lazy var emotionView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
    }
    
    private let emotionList = [ImageList.emojiJoy.name, ImageList.emojiShocked.name, ImageList.emojiLove.name, ImageList.emojiShy.name, ImageList.emojiSad.name, ImageList.emojiAngry.name]
    
    private let saveButton = UIButton().then {
        $0.setImage(ImageList.icnSaveOff.image, for: .normal)
    }

    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setGesture()
        setDelegate()
        setupView()
        setupConstraint()
        setHeaderView()
    }
    
    // MARK: - Functions
    private func setHeaderView() {
        headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "기록하기")
    }
    
    private func setDelegate() {
        headerView.delegate = self
        emotionCollectionView.delegate = self
        emotionCollectionView.dataSource = self
        contentTextView.delegate = self
    }
    
    private func setGesture() {
        var tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        tapGesture.delegate = self
        dateView.addGestureRecognizer(tapGesture)
    }
}

extension RecordViewController: Presentable, NavigationBarDelegate {
    // MARK: - constraints
    func setupConstraint() {
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(67.adjustedHeight)
        }
        
        self.dateView.snp.makeConstraints { make in
            make.height.equalTo(54.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(contentsView.snp.top).offset(32)
        }
        
        self.voiceView.snp.makeConstraints { make in
            make.height.equalTo(54.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(dateView.snp.bottom).offset(14)
        }
        
        self.titleTextField.snp.makeConstraints { make in
            make.height.equalTo(54.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(voiceView.snp.bottom).offset(14)
        }
        
        self.contentTextView.snp.makeConstraints { make in
            make.height.equalTo(418.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleTextField.snp.bottom).offset(14)
        }
        
        self.emotionLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(contentTextView.snp.bottom).offset(32)
        }
        
        self.emotionCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.emotionView.snp.makeConstraints { make in
            make.height.equalTo(60.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(emotionLabel.snp.bottom).offset(14)
            make.bottom.equalToSuperview().inset(50)
        }
        
        self.contentsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.view)
        }
        
        self.contentLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(18)
        }
        
        // content안에 있는 view들의 제약조건을 수정하였음
        // 너비지정 + centerX 코드를 지우고 leading.trailing에다가 inset을 주는걸로 -> 하드코딩이다 ?
        // scrollview 안에 contentsview가 있는데 부모자식을 못찾음 ? -> top은 있는데 bottom이 없었음. top만 연결되어 있었던 상태였음
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(75.adjustedHeight)
        }
    }

    func setupView() {
        contentTextView.addSubview(contentLable)
        emotionView.addSubview(emotionCollectionView)
        contentsView.addSubviews(dateView, voiceView, titleTextField, contentTextView, emotionLabel, emotionView)
        scrollView.addSubview(contentsView)
        self.view.addSubviews(headerView, scrollView, saveButton)
    }
    
    func navigationBackButtonDidTap() {
        print("backBtnTap")
    }
    
    func navigationMoreButtonDidTap() {}

}

// MARK: - UIGestureRecognizerDelegate
extension RecordViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }

    @objc func tapMethod(sender: UITapGestureRecognizer) {
        print("help mee plzzzz")
    }
}

// MARK: - CollectionViewDelegate
extension RecordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier, for: indexPath) as? EmotionCollectionViewCell else { return UICollectionViewCell() }
        cell.setEmotionImage(imageName: emotionList[indexPath.item])
        return cell
    }
}

// MARK: - UITextViewDelegate
extension RecordViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        contentLable.isHidden = true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if contentTextView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { contentLable.isHidden = false }
    }
}
