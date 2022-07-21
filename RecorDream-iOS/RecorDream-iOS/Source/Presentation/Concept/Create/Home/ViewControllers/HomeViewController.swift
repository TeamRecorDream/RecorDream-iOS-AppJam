//
//  HomeViewController.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/11.
//

import UIKit

import SnapKit
import Then

class HomeViewController: BaseViewController {
    private let headerView = HeaderView()
    private let homeUserNameView = UserNameView()
    private let recorDreamView = RecorDreamView()
    private let backgroundImage = UIImageView().then {
        $0.image = UIImage(named: ImageList.mainBackground.name)
    }
    let dreamManager: HomeServiceable = DreamService(apiService: APIManager(), environment: .development)
    var dreamCards: [RecordElement] = []{
        didSet {
            recorDreamView.carouselCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setDelegate()
        setRecorDreamView() // TODO: - 꿈 기록 여부에 따라 view 바꾸기
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getDreamCard()
    }
    
    override func setHierarchy() {
        view.addSubviews(backgroundImage, headerView)
    }
    
    private func setupConstraints() {
        backgroundImage.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(72)
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
    }
    
    func setEmptyView(){
        view.addSubview(homeUserNameView)
        
        homeUserNameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        homeUserNameView.setUserNameView(name: "소진", isEmpty: true) // TODO: - user name 넣기
    }
    
    func setRecorDreamView(){
        view.addSubview(recorDreamView)
        
        recorDreamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        recorDreamView.setUserNameView(name: "소진 하이", isEmpty: false) // TODO: - user name 넣기
    }
    
    func setDelegate() {
        recorDreamView.carouselCollectionView.delegate = self
        recorDreamView.carouselCollectionView.dataSource = self
    }
}

// MARK: - extension
extension HomeViewController {
    func getDreamCard() {
        Task {
            do {
                let dreams = try await dreamManager.getRecorDreamCard()
                dreamCards = dreams[0].data.records
                recorDreamView.carouselCollectionView.reloadData()
            } catch APIError.serverError {
                print("server error")
            } catch APIError.clientError(message: "하 씨") {
                print("??")
            }
        }
    }
}

// MARK: - collection view delegate
extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dreamCards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = TypeConst.smallItemSize.width
        var height = TypeConst.smallItemSize.height

        if indexPath.item == recorDreamView.cellIndex {
            width = TypeConst.itemSize.width
            height = TypeConst.itemSize.height
        }

        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCollectionViewCell.reuseIdentifier, for: indexPath) as? CardCollectionViewCell else { return UICollectionViewCell() }
//        if indexPath.item > 0 {
//            cell.update(plusAlpha: true, updateConst: true)
//            cell.setCardView(dream: dreamCards[indexPath.item])
//            cell.setHashtagStackView(genres: dreamCards[indexPath.item].genre, textColorNum: dreamCards[indexPath.item].dreamColor)
//        }
        if indexPath.item > 0 {
            cell.update(plusAlpha: true, updateConst: true)
        }
        cell.setCardView(dream: dreamCards[indexPath.item])
        cell.setHashtagStackView(genres: dreamCards[indexPath.item].genre, textColorNum: dreamCards[indexPath.item].dreamColor)
        return cell
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //MARK: - 드래그 했다가 마우스를 뗄 때 메서드
        scrollView.setContentOffset(CGPoint(x: 204.0 * CGFloat(recorDreamView.cellIndex) + 10 * CGFloat(recorDreamView.cellIndex), y: scrollView.contentInset.top), animated: true)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        //MARK: - 드래그 끝까지 끌다가 끝냈을 때 호출되는 메서드
        scrollView.setContentOffset(CGPoint(x: 204.0 * CGFloat(recorDreamView.cellIndex) + 10 * CGFloat(recorDreamView.cellIndex), y: scrollView.contentInset.top), animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        for i in 0..<dreamCards.count {
            //TODO: - 아카이브 용으로 주석을 남겨두긴 했는데 . . 마지막까지 문제가 없다면 삭제하겠습니다
//            let a = CGFloat(55 + 204 * i + 20 * i) - 102
//            let b = CGFloat(Int(a) + 264 + 20) + 102
            let a = CGFloat(55 + 204 * i + 20 * (i > 1 ? i - 1 : 0)) - 102 + 20
            let b = CGFloat(a + 264 + (i == 0 ? 0 : 20)) + 20
            if x > a && x < b {
                print("x 위치 : \(x)")
                recorDreamView.cellIndex = i
                print(recorDreamView.cellIndex )
                recorDreamView.carouselCollectionView.performBatchUpdates(nil)
            }
        }
        
        let indexPath = IndexPath(item: Int(recorDreamView.cellIndex), section: 0)
        if let cell = recorDreamView.carouselCollectionView.cellForItem(at: indexPath) as? CardCollectionViewCell {
            cell.update(plusAlpha: false, updateConst: false)
        }
        
        if Int(recorDreamView.cellIndex) != recorDreamView.previousIndex {
            let preIndexPath = IndexPath(item: recorDreamView.previousIndex, section: 0)
            if let preCell = recorDreamView.carouselCollectionView.cellForItem(at: preIndexPath) as? CardCollectionViewCell {
                preCell.update(plusAlpha: true, updateConst: false)
            }
            recorDreamView.previousIndex = indexPath.item
        }
    
    }
}
