//
//  StorageView+CompositionalLayout.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/20.
//

import UIKit

extension StorageView {
    // MARK: - Filter
    func makeFilterCaseLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            // 섹션 안에 여러 개 있는게 그룹! (아이템은 그룹 안에 여러개)
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.adjustedHeight)) // 절대값(가로), 조절 1(세로)
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(50.adjustedHeight))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitem: item, count: 1) // subitems
            
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [self.makeFilterCaseHeader()]
            section.interGroupSpacing = 14
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 16, leading: 16, bottom: 16, trailing: 16)
            
            return section
        }
        return layout
    }
    
    func makeFilterCaseHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
        let filterHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(31.adjustedHeight))
        let filterHeaderElement = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: filterHeaderSize,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .leading)
        return filterHeaderElement
    }
    
    // MARK: - Gallary
    func makeGallaryCaseLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(208.adjustedHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(208.adjustedHeight))
            let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 9
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 18, leading: 16, bottom: 18, trailing: 16)
            
            return section
        }
        return layout
    }
    
    // MARK: - List
    func makeListCaseLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(104.adjustedHeight))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)

            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(104.adjustedHeight))
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize, subitem: item, count: 1)
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            section.contentInsets = NSDirectionalEdgeInsets(
                top: 18, leading: 16, bottom: 18, trailing: 16)
            
            return section
        }
        return layout
    }
}
