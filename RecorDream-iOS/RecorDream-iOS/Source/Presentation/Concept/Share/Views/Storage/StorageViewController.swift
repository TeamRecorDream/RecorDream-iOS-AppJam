//
//  StorageViewController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

final class StorageViewController: BaseViewController {
    private let storageView = StorageView()
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = self.storageView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
    }
    
    override func setTargets() {
        self.storageView.navigationBarView.searchButton.addTarget(
            self,
            action: #selector(presentSearchViewController),
            for: .touchUpInside)
    }
}

// MARK: - Extensions
extension StorageViewController {
    private func assignDelegation() {
        self.storageView.filterCollectionView.dataSource = self
        self.storageView.storageCollectionView.dataSource = self
    }
    
    @objc
    private func presentSearchViewController() {
        let searchViewController = SearchViewController.instanceFromNib()
        searchViewController.modalPresentationStyle = .overFullScreen
        searchViewController.modalTransitionStyle = .crossDissolve
        self.present(searchViewController, animated: false)
    }
}

extension StorageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case self.storageView.filterCollectionView:
            return 8
        case self.storageView.storageCollectionView:
            return 0    // TODO: - 서버통신 결과값으로 넘기기
        default:
            return 0    // 흠...
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case self.storageView.filterCollectionView:
            let filterCell = storageView.filterCollectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as! FilterCollectionViewCell
//            filterCell.setFilter(emotion: emotionImageList[indexPath.row])
            return filterCell
        case self.storageView.storageCollectionView:
            let cell = storageView.storageCollectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.reuseIdentifier, for: indexPath) as! ListCollectionViewCell
            return cell
        default:
            assert(false)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch collectionView {
        case self.storageView.filterCollectionView:
            guard let filterHeader = storageView.filterCollectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionHeader,
                withReuseIdentifier: FilterCollectionHeaderView.reuseIdentifier,
                for: indexPath) as? FilterCollectionHeaderView
            else { return UICollectionReusableView() }
            return filterHeader
        default:
            assert(false)
        }
    }
}
