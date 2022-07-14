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
    static let itemSize = CGSize(width: 264, height: 392) //기존 사이즈
    static let itemSpacing = 20.0
    
    static var insetX: CGFloat {
        (UIScreen.main.bounds.width - TypeConst.itemSize.width) / 2.0
    }
    
    static var collectionViewContentInset: UIEdgeInsets {
        UIEdgeInsets(top:0, left: TypeConst.insetX, bottom: 0, right: TypeConst.insetX)
    }
}

class RecorDreamView: BaseView {
    let userNameView = UserNameView()
    var previousIndex = 0
    var cellIndex: Int = 0
    
    let collectionViewFlowLayout = UICollectionViewFlowLayout().then {
        $0.scrollDirection = .horizontal
        $0.itemSize = TypeConst.itemSize
        $0.minimumLineSpacing = TypeConst.itemSpacing
        $0.sectionInset = TypeConst.collectionViewContentInset
    }
    
    lazy var carouselCollectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewFlowLayout).then {
        $0.register(CardCollectionViewCell.self, forCellWithReuseIdentifier: CardCollectionViewCell.identifier)
        $0.isPagingEnabled = false
        $0.decelerationRate = .fast
        $0.contentInsetAdjustmentBehavior = .never
        $0.backgroundColor = .clear
        $0.showsHorizontalScrollIndicator = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setDelegate()
    }
    
    override func setupView() {
        addSubviews(userNameView, carouselCollectionView)
    }
    
    override func setupConstraint() {
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
    
    func setDelegate() {
        carouselCollectionView.delegate = self
        carouselCollectionView.dataSource = self
    }
    
    func setUserName(_ name: String, _ isEmpty: Bool) {
        userNameView.setUserName(name, isEmpty)
    }
}

// MARK: - extension
extension RecorDreamView: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5 // TODO: - 꿈 기록 카드에 맞게 바꿔두기
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = 204.0
        var height = 314.0

        if indexPath.item == cellIndex {
            width = TypeConst.itemSize.width
            height = TypeConst.itemSize.height
        }

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.identifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
        if indexPath.item > 0 {
            cell.prepare(plusAlpha: true, updateConst: true)
        }
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //MARK: - 드래그 했다가 마우스를 뗄 때 메서드
        scrollView.setContentOffset(CGPoint(x: 204.0 * CGFloat(cellIndex) + 10 * CGFloat(cellIndex), y: scrollView.contentInset.top), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //MARK: - 드래그 끝까지 끌다가 끝냈을 때 호출되는 메서드
//        0
//        204 * 1 + 20 / 2
//        204 * 2 + 20
//        204 * 3 + 20 + 20 / 2
//        204 * 4 + 20 + 20
        scrollView.setContentOffset(CGPoint(x: 204.0 * CGFloat(cellIndex) + 10 * CGFloat(cellIndex), y: scrollView.contentInset.top), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        for i in 0..<5 { // TODO: - 카드 개수로 맞추기
//            let a = CGFloat(55 + 204 * i + 20 * (i > 1 ? i - 1 : 0)) - 102 + 20
//            let b = CGFloat(a + 264 + (i == 0 ? 0 : 20)) + 20
            let a = CGFloat(55 + 204 * i + 20 * i) - 102
            let b = CGFloat(Int(a) + 264 + 20) + 102
            if x > a && x < b {
                cellIndex = i
                carouselCollectionView.performBatchUpdates(nil)
            }
        }
        
        let indexPath = IndexPath(item: Int(cellIndex), section: 0)
        if let cell = carouselCollectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            cell.prepare(plusAlpha: false, updateConst: false)
        }
        
        if Int(cellIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = carouselCollectionView.cellForItem(at: preIndexPath) as? CardCollectionViewCell {
                preCell.prepare(plusAlpha: true, updateConst: false)
            }
            previousIndex = indexPath.item
        }
    
    }
}
