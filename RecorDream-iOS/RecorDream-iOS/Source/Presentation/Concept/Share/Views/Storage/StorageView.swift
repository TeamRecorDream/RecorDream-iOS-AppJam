//
//  StorageView.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

final class StorageView: BaseView {
    let navigationBarView = HeaderView()
    var filterCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.register(
            FilterCollectionHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: FilterCollectionHeaderView.reuseIdentifier
        )
        $0.register(
            FilterCollectionViewCell.self,
            forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier
        )
        $0.showsHorizontalScrollIndicator = false
    }
    let storageHeaderView = StorageHeaderView()
    var storageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        $0.register(
            GallaryCollectionViewCell.self, forCellWithReuseIdentifier: GallaryCollectionViewCell.reuseIdentifier
        )
        $0.register(
            ListCollectionViewCell.self,
            forCellWithReuseIdentifier: ListCollectionViewCell.reuseIdentifier
        )
        $0.showsVerticalScrollIndicator = false
    }
    
    override func setupView() {
        self.backgroundColor = ColorType.darkBlue01.color
        self.addSubviews(navigationBarView, filterCollectionView, storageHeaderView, storageCollectionView)
        
        self.filterCollectionView.collectionViewLayout = makeFilterCaseLayout()
        
        self.storageCollectionView.collectionViewLayout = makeGallaryCaseLayout()   // 초기화면
        
        // 버튼 누름
        
        self.storageCollectionView.collectionViewLayout = makeListCaseLayout()  // 바뀔때 넣어줌!
    }
    override func setupConstraint() {
        self.navigationBarView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(72.adjustedHeight)
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
        }
        self.filterCollectionView.snp.makeConstraints { make in
            make.height.equalTo(112.adjustedHeight)
            make.top.equalTo(navigationBarView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        self.storageHeaderView.snp.makeConstraints { make in
            make.height.equalTo(34.adjustedHeight)
            make.top.equalTo(filterCollectionView.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
        self.storageCollectionView.snp.makeConstraints { make in
            make.height.equalTo(448.adjustedHeight)
            make.top.equalTo(storageHeaderView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
