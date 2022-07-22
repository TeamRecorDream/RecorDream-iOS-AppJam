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
    var index: Int = 0
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
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
        $0.placeholder = "꿈의 제목을 남겨주세요."
        $0.addLeftPadding(width: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "꿈의 제목을 남겨주세요.", attributes: [NSAttributedString.Key.foregroundColor : ColorType.white02.color])
    }
    private lazy var contentTextView = UITextView().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white01.color
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
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
        $0.backgroundColor = .clear
    }
    
    private lazy var dreamColorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(RecordBarCollectionViewCell.self, forCellWithReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier)
        $0.backgroundColor = .clear
    }
    
    private lazy var emotionView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
    }
    
    private lazy var dreamColorView = UIView().then {
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
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
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue03.color.cgColor)
        $0.textContainerInset = UIEdgeInsets.init(top: 18, left: 16, bottom: 18, right: 16)
    }
    
    private let toastTextLabel = UILabel().then {
        $0.text = "꿈의 제목을 입력해주세요."
    }
    
    private let toastMessageView = UIView().then {
        $0.backgroundColor = ColorType.warningGray.color
        $0.makeRoundedWithBorder(radius: 10, borderColor: ColorType.warningGray.color.cgColor)
        $0.alpha = 0
    }
    
    private let chipColorList: [Array<Any>] = [
        [ImageList.colorChipColorRed.name, 6],
        [ImageList.colorChipColorOrange.name, 3],
        [ImageList.colorChipColorPink.name, 5],
        [ImageList.colorChipColorPurple.name, 4],
        [ImageList.colorChipColorGreen.name , 1],
        [ImageList.colorChipColorBlue.name, 2]
    ]
    
    private let saveButton = UIButton().then {
        $0.setImage(ImageList.icnSaveOff.image, for: .normal)
    }
    
    static var isTouchedIndex: [Int] = []

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
        resetTextStatus()
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
    }
    
    private func setGesture() {
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dateViewDidTap))
        tapGesture.delegate = self
        dateView.addGestureRecognizer(tapGesture)
    }
    
    internal override func setTargets() {
        titleTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
    private func resetTextStatus() {
        titleTextField.text?.removeAll()
        noteTextView.text?.removeAll()
        contentTextView.text?.removeAll()
    }
    
    private func setHashtagView() {
        HashtagView.isTouchedCount = 0
        for index in 0..<5 {
            let hashtagView = HashtagView()
            hashtagView.setRecordLabel(text: "# \(Constant.Genre.genreTitles[index])")
        
            let genreTapGesture = GenreTapGestureRecognizer(target: self, action: #selector(genreViewDidTap))
            genreTapGesture.index = index
            genreTapGesture.hashtagView = hashtagView
            
            hashtagView.addGestureRecognizer(genreTapGesture)
            
            genresTopStackView.addArrangedSubview(hashtagView)
            
            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(30.adjustedHeight)
            }
        }
        
        for index in 5..<Constant.Genre.genreTitles.count - 1 {
            let hashtagView = HashtagView()
            hashtagView.setRecordLabel(text: "# \(Constant.Genre.genreTitles[index])")

            let genreTapGesture = GenreTapGestureRecognizer(target: self, action: #selector(genreViewDidTap))
            genreTapGesture.index = index
            genreTapGesture.hashtagView = hashtagView
            
            hashtagView.addGestureRecognizer(genreTapGesture)

            genresBottomStackView.addArrangedSubview(hashtagView)

            hashtagView.snp.makeConstraints { make in
                make.height.equalTo(30.adjustedHeight)
            }
        }
    }
    
    @objc func textFieldDidChange() {
        if let title = titleTextField.text {
            if !title.isEmpty && !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // MARK: - 저장 가능 상태
                saveButton.setImage(UIImage(named: ImageList.icnSaveOn.name), for: .normal)
            } else {
                // MARK: - 저장 불가능 상태
                saveButton.setImage(UIImage(named: ImageList.icnSaveOff.name), for: .normal)
            }
        }
    }
    
    @objc func saveButtonDidTap() {
        if let title = titleTextField.text {
            if !title.isEmpty && !title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // MARK: - 저장 가능 상태
            } else {
                // MARK: - 저장 불가능 상태
                UIView.animate(withDuration: 1.25, delay: 0.01, options: .curveEaseIn, animations: {
                    self.toastMessageView.alpha = 1.0
                }, completion: {_ in
                    self.toastMessageView.removeFromSuperview()
                })
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
        
        self.contentLable.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(18)
            make.leading.equalToSuperview().inset(18)
        }
        
        self.contentTextView.snp.makeConstraints { make in
            make.height.equalTo(418.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(titleTextField.snp.bottom).offset(14)
        }
        
        // MARK: - 나의 감정
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
        
        // MARK: - 꿈의 색상
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
        
        // MARK: - 꿈의 장르
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
        
        // MARK: - 노트 부분
        self.noteLabel.snp.makeConstraints { make in
            make.top.equalTo(noticeLabel.snp.bottom).offset(11)
            make.leading.equalToSuperview().inset(16)
        }
        
        self.noteTextView.snp.makeConstraints { make in
            make.height.equalTo(212.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(noteLabel.snp.bottom).offset(16)
            make.bottom.equalToSuperview().inset(70)
        }
        
        self.contentsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.view)
        }
        
        self.scrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        self.saveButton.snp.makeConstraints { make in
            make.leading.bottom.trailing.equalToSuperview()
            make.height.equalTo(75.adjustedHeight)
        }
        
        self.toastTextLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        self.toastMessageView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(29)
            make.height.equalTo(44.adjustedHeight)
            make.bottom.equalTo(saveButton.snp.top).offset(-40)
        }
        
    }

    func setupView() {
        toastMessageView.addSubview(toastTextLabel)
        contentTextView.addSubview(contentLable)
        emotionView.addSubview(emotionCollectionView)
        dreamColorView.addSubview(dreamColorCollectionView)
        contentsView.addSubviews(dateView, voiceView, titleTextField, contentTextView, emotionLabel, emotionView, dreamColorLabel, dreamColorView, genreLable, genresTopStackView, genresBottomStackView, noticeLabel, noteLabel, noteTextView)
        scrollView.addSubview(contentsView)
        self.view.addSubviews(headerView, scrollView, saveButton, toastMessageView)
    }
    
    func navigationBackButtonDidTap() {
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
    }
    
    func navigationMoreButtonDidTap() {}
}

// MARK: - UIGestureRecognizerDelegate
extension RecordViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }

    @objc func dateViewDidTap(sender: UITapGestureRecognizer) {
        let modalVC = DateModalViewController()
        modalVC.dateClosure = { date in
            self.dateView.setRecordDateLabel(date: date)
        }
        modalVC.modalPresentationStyle = .custom
        self.present(modalVC, animated: true, completion: nil)
    }

    @objc func genreViewDidTap(sender: GenreTapGestureRecognizer) {
        sender.setIsTouched()
        
        guard let view = sender.hashtagView else { return }
        guard let isTouched = sender.isTouched else { return }
        view.calculateIsTouchCount(addCount: isTouched)
        let count = view.touchedCount()
        
        if isTouched && count >= 4 { // MARK: - 터치된 것 뺌
            sender.setIsTouched()
            view.calculateIsTouchCount(addCount: !isTouched)
            RecordViewController.isTouchedIndex = RecordViewController.isTouchedIndex.filter {
                $0 != sender.index
            }
            noticeLabel.isHidden = false
        } else if isTouched && count <= 3 { // MARK: - 터치됨
            view.setSelectedRecordLabel()
            RecordViewController.isTouchedIndex.append(sender.index)
            noticeLabel.isHidden = true
        } else if !isTouched { // MARK: - 터치 안된 상태
            view.resetSelectedRecordLabel()
            RecordViewController.isTouchedIndex = RecordViewController.isTouchedIndex.filter {
                $0 != sender.index
            }
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
            cell.setRecordBarImage(imageName: Constant.Emotion.IntType(indexPath.item + 1).title)
            return cell
        } else if collectionView == dreamColorCollectionView {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecordBarCollectionViewCell.reuseIdentifier, for: indexPath) as? RecordBarCollectionViewCell else { return UICollectionViewCell() }
            cell.setRecordBarImage(imageName: chipColorList[indexPath.item][0] as? String ?? ImageList.colorChipColorRed.name) //TODO: - optional 처리
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: - 서버통신시 index 넣어주기 
        if collectionView == emotionCollectionView {
            print("emotionCell :\(indexPath.item + 1)")
        } else if collectionView == dreamColorCollectionView {
            print("dreamColorCell :\(indexPath.item)")
            print("dreamColorIndex : \(chipColorList[indexPath.item][1])")
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

