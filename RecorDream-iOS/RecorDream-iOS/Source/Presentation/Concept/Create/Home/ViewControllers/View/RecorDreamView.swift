//
//  RecorDreamView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/12.
//

import UIKit

import SnapKit
import Then

enum TypeConst {
    static let itemSize = CGSize(width: 264, height: 392)
    static let smallItemSize = CGSize(width: 204, height: 314)
    static let itemSpacing = 20.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - TypeConst.itemSize.width) / 2.0
    }
    
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top:0, left: TypeConst.insetX, bottom: 0, right: TypeConst.insetX)
    }
}

class RecorDreamView: BaseView {
    private let userNameView = UserNameView()
    var previousIndex = 0
    var cellIndex: Int = 0
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = TypeConst.itemSize
        $0.minimumLineSpacing = TypeConst.itemSpacing
        $0.sectionInset = TypeConst.collectionViewContentInset
    }
    
    lazy var carouselCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.reuseIdentifier)
        $0.isPagingEnabled = false
        $0.decelerationRate = .fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setDelegate()
//    }
    
    override func setupView() {
        super.setupView()
        addSubviews(userNameView, carouselCollectionView)
    }
    
    override func setupConstraint() {
        super.setupConstraint()
        
        userNameView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(28)
            make.top.equalToSuperview().offset(11)
        }
        
        carouselCollectionView.snp.makeConstraints { make in
            make.top.equalTo(userNameView.snp.bottom).offset(42)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(TypeConst.itemSize.height)
        }
    }
    
    func setUserNameView(name: String, isEmpty: Bool) {
        userNameView.setUserNameView(name: name, isEmpty: isEmpty)
    }
}

