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

class RecordViewController: BaseViewController {
    // MARK: - Properties
    private let headerView = RecordHeaderView()
    private let dateView = RecordDateBarView()
    private let voiceView = RecordVoiceBarView()
    private let scrollView = UIScrollView()
    private let contentsView = UIView()
    private let titleTextField = UITextField().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white02.color // TODO: - light_blue03 으로 변경해야함
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
        $0.placeholder = "꿈의 제목을 남겨주세요."
        $0.addLeftPadding(width: 16)
    }
    let textViewPlaceHolder = "꿈을 기록해주세요."
    private lazy var contentTextView = UITextView().then {
        $0.font = TypoStyle.title2.font
        $0.tintColor = ColorType.white02.color // TODO: - light_blue03 으로 변경해야함
        $0.backgroundColor = ColorType.darkBlue02.color
        $0.makeRoundedWithBorder(radius: 8, borderColor: ColorType.lightBlue02.color.cgColor)
        $0.text = textViewPlaceHolder
    }
    // 송영모 하트
    //collectionView
//    static let itemSize = CGSize(width: 54.adjustedWidth, height: 60.adjustedHeight)
//    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
//        $0.scrollDirection = .horizontal
//        $0.itemSize = RecordViewController.itemSize
////        $0.sectionInset = TypeConst.collectionViewContentInset
//    }
//
//    lazy var emotionCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
//        $0.register(EmotionCollectionViewCell.self, forCellWithReuseIdentifier: EmotionCollectionViewCell.reuseIdentifier)
//        $0.isPagingEnabled = false
//        $0.decelerationRate = .fast
//        $0.contentInsetAdjustmentBehavior = .never
//        $0.backgroundColor = .clear
//    }
    
    private let saveButton = UIButton().then {
        $0.setImage(ImageList.icnSaveOff.image, for: .normal)
    }
    
    private let testView = UIView().then {
        $0.backgroundColor = .white
    }
    
    private var contentsHeight:Double = ( 54 + 54 + 300 + 32 + 14 + 14 + 418 + 100).adjustedHeight
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapMethod))
        tapGesture.delegate = self
        dateView.addGestureRecognizer(tapGesture)
        
        setupView()
        setupConstraint()
        setHeaderView()
        setDelegate()
    }
    
    // MARK: - Functions
    private func setHeaderView() {
        headerView.setHeaderView(HiddenMoreBtn: true, headerLabelText: "기록하기")
    }
    
    private func setDelegate() {
        headerView.delegate = self
    }
}

extension RecordViewController: Presentable, NavigationBarDelegate, UIGestureRecognizerDelegate {
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
//            make.bottom.
            make.top.equalTo(titleTextField.snp.bottom).offset(14)
        }
        
        self.testView.snp.makeConstraints { make in
            make.height.equalTo(300.adjustedHeight)
            make.leading.trailing.equalToSuperview().inset(16)
            make.top.equalTo(contentTextView.snp.bottom).offset(14)
            make.bottom.equalToSuperview()
        }
        
        self.contentsView.snp.makeConstraints { make in
            make.top.equalTo(scrollView.snp.top)
            make.bottom.equalToSuperview()
            make.leading.trailing.equalTo(self.view)
//            make.width.equalTo(375.adjustedWidth)
//            make.height.equalTo(contentsHeight)
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
        contentsView.addSubviews(dateView, voiceView, titleTextField, contentTextView, testView)
        scrollView.addSubviews(contentsView)
//        contentsView.bringSubviewToFront(titleTextField)
        self.view.addSubviews(headerView, scrollView, saveButton)
    }
    
    func navigationBackButtonDidTap() {
        print("backBtnTap")
    }
    
    func navigationMoreButtonDidTap() {}
    
    @objc func tapMethod(sender: UITapGestureRecognizer) {
        print("help mee plzzzz")
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool{
        return true
    }
    
}
