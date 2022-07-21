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
  
        cell.setCardView(dream: dreamCards[indexPath.item])
        cell.setHashtagStackView(genres: dreamCards[indexPath.item].genre, textColorNum: dreamCards[indexPath.item].dreamColor)
        
        if indexPath.item == recorDreamView.cellIndex {
            cell.update(plusAlpha: false, updateConst: false)
        } else {
            cell.update(plusAlpha: true, updateConst: true)
        }

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
            let a = CGFloat( 55 * i + 144 * i )
            let b = CGFloat(Int(a) + 132 + 55)
            if x > a && x < b {
                recorDreamView.cellIndex = i
                recorDreamView.carouselCollectionView.performBatchUpdates(nil, completion: { _ in
                    self.recorDreamView.carouselCollectionView.reloadData()
                })
                // cell size 가 Batch로 바뀌는데 ,batch는 크기만 관여. data는 관여하지 않음. reloadData는 delegate 함수가 동작됨. perform은 크기만 관여해서 update문이 실행이 안됐던것임
            }
        }
    
    }
}
