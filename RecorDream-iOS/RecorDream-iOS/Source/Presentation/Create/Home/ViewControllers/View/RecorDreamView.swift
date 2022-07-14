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
            make.centerX.equalToSuperview()
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
//        print(cell)
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidth = TypeConst.itemSize.width + TypeConst.itemSpacing
        let offset = targetContentOffset.pointee.x + TypeConst.insetX
        print("endDragging: \(offset)")
        let index: CGFloat = round(offset / cellWidth)

        targetContentOffset.pointee = CGPoint(x: index * cellWidth - scrollView.contentInset.left, y: scrollView.contentInset.top)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let cellWidth = TypeConst.itemSize.width + TypeConst.itemSpacing
        let offset = scrollView.contentOffset.x
        print("didScroll: \(offset)")
        let index: CGFloat = round(offset / cellWidth)
        cellIndex = Int(round(index))
        print("cellIndex: \(cellIndex)")
        carouselCollectionView.performBatchUpdates(nil) //TODO: -
        let roundedIndex = round(index)
        let indexPath = IndexPath(item: Int(roundedIndex), section: 0)
        
        if let cell = carouselCollectionView.cellForItem(at:indexPath) as? CardCollectionViewCell {
            animateZoomforCell(zoomCell: cell)
            cell.backgroundImage.alpha = 1
//            cell.updateCell()#imageLiteral(resourceName: "simulator_screenshot_145A8932-7CB6-4A68-8A57-8CED952A9694.png")
        }
    
        if Int(roundedIndex) != previousIndex {
            let preIndexPath = IndexPath(item: previousIndex, section: 0)
            if let preCell = collectionView(carouselCollectionView, cellForItemAt: preIndexPath) as? CardCollectionViewCell {
                animateZoomforCellremove(zoomCell: preCell)
            }
            previousIndex = indexPath.item
        }
    
    }
    
    func animateZoomforCell(zoomCell: UICollectionViewCell) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                zoomCell.transform = .identity
            },
            completion: nil)
    }
    
    func animateZoomforCellremove(zoomCell: UICollectionViewCell) {
        UIView.animate(
            withDuration: 0.2,
            delay: 0,
            options: .curveEaseOut,
            animations: {
                zoomCell.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            },
            completion: nil)
        
    }
}
