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

class GenreTapGestureRecognizer: UITapGestureRecognizer {
    var index: Int?
    var hashtagView: HashtagView?
    var isTouched: Bool? = false
    
    func setIsTouched() {
        self.isTouched?.toggle()
    }
}

class RecordViewController: BaseViewController {
    // MARK: - Properties
    private let headerView = RecordHeaderView()
    private let dateView = RecordDateBarView()
    private let voiceView = RecordVoiceBarView()
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
    }
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
    private lazy var contentTextView = UITextView().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor) // TODO: - light_blue03 으로 변경해야함
        $0.textContainerInset = UIEdgeInsets.init(top: 18, left: 16, bottom: 18, right: 16)
    }
    
    private let contentLable = UILabel().then {
        $0.text = "꿈을 기록해주세요."
        $0.font = TypoStyle.title2.font
        $0.textColor = ColorType.white02.color
    }
    
    private let emotionLabel = UILabel().then {
        $0.setLabel()
        $0.text = "나의 감정"
    }
    
    private let dreamColorLabel = UILabel().then {
        $0.setLabel()
        $0.text = "꿈의 색상"
    }
    
    private let genreLable = UILabel().then {
        $0.setLabel()
        $0.text = "꿈의 장르"
    }
    
    private let noteLabel = UILabel().then {
        $0.setLabel()
        $0.text = "노트"
    }
    
    private let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = CollectionViewConst.itemSize
        $0.sectionInset = CollectionViewConst.collectionViewContentInset
    }

    private lazy var emotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(RecordBarCollectionViewCell.self, forCellWithReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier)
        $0.isPagingEnabled = false
        $0.decelerationRate = .fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
    }
    
    private lazy var dreamColorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(RecordBarCollectionViewCell.self, forCellWithReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier)
        $0.isPagingEnabled = false
        $0.decelerationRate = .fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
    }
    
    private lazy var emotionView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
    }
    
    private lazy var dreamColorView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
    }
    
    private lazy var genresTopStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 11
    }
    
    private lazy var genresBottomStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .leading
        $0.spacing = 11
    }
    
    private var noticeLabel = UILabel().then {
        $0.text = "!꿈의 장르는 최대 3개까지만 선택할 수 있어요."
        $0.font = TypoStyle.subtitle7.font
        $0.textColor = ColorType.red.color
        $0.isHidden = true
    }
    
    private let noteTextView = UITextView().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor) // TODO: - light_blue03 으로 변경해야함
        $0.textContainerInset = UIEdgeInsets.init(top: 18, left: 16, bottom: 18, right: 16)
    }
    
    private let dreamColorList = [ImageList.colorChipColorRed.name, ImageList.colorChipColorOrange.name, ImageList.colorChipColorPink.name, ImageList.colorChipColorPurple.name, ImageList.colorChipColorGreen.name, ImageList.colorChipColorBlue.name]
    
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
        setHashtagView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        resetSaveButton()
    }
    
    // MARK: - Functions
    private func setHeaderView() {
        headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "기록하기")
    }
    
    private func setDelegate() {
        headerView.delegate = self
        emotionCollectionView.delegate = self
        emotionCollectionView.dataSource = self
        dreamColorCollectionView.delegate = self
        dreamColorCollectionView.dataSource = self
        contentTextView.delegate = self
//        genreTapGesture.delegate = self
    }
    
    private func setGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        tapGesture.delegate = self
        dateView.addGestureRecognizer(tapGesture)
    }
    
    internal override func setTargets() {
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    private func resetSaveButton() {
        saveButton.isUserInteractionEnabled = false
        titleTextField.text?.removeAll()
    }
    
    private func setHashtagView() {
        
        for index in 0..<5 {
            let hashtagView = HashtagView()
            hashtagView.paddingLabel.setPadding(padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
            hashtagView.setRecordLabel(text: "# \(Constant.Genre.genreTitles[index])")
        
            let genreTapGesture = GenreTapGestureRecognizer(target: self, action: #selector(genreTapMethod))
            genreTapGesture.index = index
            genreTapGesture.hashtagView = hashtagView
            
            hashtagView.addGestureRecognizer(genreTapGesture)
            
            genresTopStackView.addArrangedSubview(hashtagView)
            
            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
        
        for index in 5..<Constant.Genre.genreTitles.count {
            let hashtagView = HashtagView()
            hashtagView.paddingLabel.setPadding(padding: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
            hashtagView.setRecordLabel(text: "# \(Constant.Genre.genreTitles[index])")

            let genreTapGesture = GenreTapGestureRecognizer(target: self, action: #selector(genreTapMethod))
            genreTapGesture.index = index
            genreTapGesture.hashtagView = hashtagView
            
            hashtagView.addGestureRecognizer(genreTapGesture)

            genresBottomStackView.addArrangedSubview(hashtagView)

            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(30)
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if let title = titleTextField.text {
            if !title.isEmpty {
                saveButton.isUserInteractionEnabled = true
                saveButton.setImage(UIImage(named: ImageList.icnSaveOn.name), for: .normal)
            } else {
                saveButton.isUserInteractionEnabled = false
                saveButton.setImage(UIImage(named: ImageList.icnSaveOff.name), for: .normal)
            }
        }
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
        
        // MARK: - 나의 감정 + 꿈의 색상 관련된
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
        }
        
        self.dreamColorLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(emotionView.snp.bottom).offset(32)
        }

        self.dreamColorCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        self.dreamColorView.snp.makeConstraints { make in
            make.height.equalTo(60.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(dreamColorLabel.snp.bottom).offset(14)
        }
        
        self.genreLable.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(dreamColorView.snp.bottom).offset(32)
        }
        
        self.genresTopStackView.snp.makeConstraints { make in
            make.height.equalTo(30.adjustedHeight)
            make.leading.equalToSuperview().inset(16)
            make.top.equalTo(genreLable.snp.bottom).offset(16)
        }
        
        self.genresBottomStackView.snp.makeConstraints { make in
            make.top.equalTo(genresTopStackView.snp.bottom).offset(8)
            make.height.equalTo(30.adjustedHeight)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.noticeLabel.snp.makeConstraints { make in
            make.top.equalTo(genresBottomStackView.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.noteLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.noteTextView.snp.makeConstraints { make in
            make.height.equalTo(212.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(noteLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(60)
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
        dreamColorView.addSubview(dreamColorCollectionView)
        contentsView.addSubviews(dateView, voiceView, titleTextField, contentTextView, emotionLabel, emotionView, dreamColorLabel, dreamColorView, genreLable, genresTopStackView, genresBottomStackView, noticeLabel, noteLabel, noteTextView)
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
    
    @objc func genreTapMethod(sender: GenreTapGestureRecognizer) {
        sender.setIsTouched()
        
        guard let view = sender.hashtagView else { return }
        guard let isTouched = sender.isTouched else { return }
        view.calculateIsTouchCount(addCount: isTouched)
        let count = view.touchedCount()
        
        if isTouched && count >= 4 {
            sender.setIsTouched()
            view.calculateIsTouchCount(addCount: !isTouched)
            noticeLabel.isHidden = false
        } else if isTouched && count <= 3 {
            view.setSelectedRecordLabel()
            noticeLabel.isHidden = true
        } else if !isTouched {
            view.resetSelectedRecordLabel()
            noticeLabel.isHidden = true
        } else {
            print("error")
        }
        
    }
}

// MARK: - CollectionViewDelegate
extension RecordViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == emotionCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier, for: indexPath) as? RecordBarCollectionViewCell else { return UICollectionViewCell() }
            cell.setRecordBarImage(imageName: Constant.Emotion.IntType(indexPath.item).title)
            return cell
        } else if collectionView == dreamColorCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier, for: indexPath) as? RecordBarCollectionViewCell else { return UICollectionViewCell() }
            cell.setRecordBarImage(imageName: dreamColorList[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - 서버통신시 index 넣어주기 
        if collectionView == emotionCollectionView {
            print("emotionCell :\(indexPath.item)")
        } else if collectionView == dreamColorCollectionView {
            print("dreamColorCell :\(indexPath.item)")
        }
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

// MARK: - record view에서만 사용될 메서드
extension UILabel {
    func setLabel(){
        self.font = TypoStyle.title2.font
        self.tintColor = ColorType.white01.color
    }
}
