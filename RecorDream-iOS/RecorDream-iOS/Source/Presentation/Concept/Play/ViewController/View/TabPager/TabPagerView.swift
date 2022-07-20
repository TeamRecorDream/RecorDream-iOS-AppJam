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
            cell.configureCell(isHidden: false)
            return cell
        }
        
        return UICollectionViewCell()
    }
}

extension TabPagerView: UICollectionViewDelegate {
    //셀 클릭 시 해당 콘텐츠 뷰로 이동
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.scrollToIndex(to: indexPath.row)
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
