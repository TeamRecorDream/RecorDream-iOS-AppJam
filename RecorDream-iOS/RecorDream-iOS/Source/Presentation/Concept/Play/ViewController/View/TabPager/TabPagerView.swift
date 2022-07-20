//
//  TabPagerView.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/20.
//

import UIKit

class TabPagerView: UIView {
    @IBOutlet weak var titleCollectionView: UICollectionView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    @IBOutlet weak var indicatorLeading: NSLayoutConstraint!
    private let titles = ["나의 꿈 기록", "노트"]
    var delegate: TabPagerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if let view = Bundle.main.loadNibNamed("TabPagerView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            addSubview(view)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        if let view = Bundle.main.loadNibNamed("TabPagerView", owner: self, options: nil)?.first as? UIView {
            view.frame = self.bounds
            addSubview(view)
        }
        configureTitleCollectionView()
        configureContentCollectionView()
    }
    
    private func configureTitleCollectionView() {
        self.titleCollectionView.register(TabPagerTitleCollectionViewCell.nib(), forCellWithReuseIdentifier: TabPagerTitleCollectionViewCell.identifier)
        
        self.titleCollectionView.dataSource = self
        self.titleCollectionView.delegate = self
    }
    
    private func configureContentCollectionView() {
        self.contentCollectionView.register(TabPagerContentCollectionViewCell.nib(), forCellWithReuseIdentifier: TabPagerContentCollectionViewCell.identifier)
        
        self.contentCollectionView.dataSource = self
        self.contentCollectionView.delegate = self
    }
}

extension TabPagerView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabPagerTitleCollectionViewCell.identifier,
            for: indexPath
        )
        
        if let cell = cell as? TabPagerTitleCollectionViewCell {
            cell.configureCell(titles[indexPath.row])
            return cell
        }
        if let cell = cell as? TabPagerContentCollectionViewCell {
            cell.configureCell(isHidden: indexPath.row == 0 ? false : true)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension TabPagerView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabPagerTitleCollectionViewCell.identifier,
            for: indexPath
        )
        
        if cell is TabPagerTitleCollectionViewCell {
            //TODO: - 노트, 즉 1번 탭 클릭 시 이동 안 하거나 0번으로 이동 수정 필요
            contentCollectionView.scrollToItem(at: IndexPath(row: indexPath.row, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    //content 슬라이드 시 인디케이터 이동
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        indicatorLeading.constant = scrollView.contentOffset.x / 2
    }
}

extension TabPagerView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TabPagerTitleCollectionViewCell.identifier,
            for: indexPath
        )
        
        if cell is TabPagerTitleCollectionViewCell {
            return CGSize(width: (UIScreen.main.bounds.width)/2, height: (self.frame.height) / 6)
        }
        if cell is TabPagerContentCollectionViewCell {
            return self.contentCollectionView.frame.size
        }
        
        return CGSize()
    }
}
