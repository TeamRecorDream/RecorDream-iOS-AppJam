//
//  RecordDetailViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/19.
//

import UIKit

class RecordDetailViewController: BaseViewController {
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var emotionImage: UIImageView!
    
    private var headerView = RecordHeaderView()
    //TODO: - 서버 연결 시 사용할 프로퍼티
    private var genres = [8, 4, 1]
    private var dreamColor = 1
    private var emotion = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureGenreView()
        configureHeaderView()
    }
    
    private func configureView(){
        self.emotionImage.image = UIImage(named: Constant.Emotion.IntType(emotion).title)
    }
    
    private func configureHeaderView(){
        self.view.addSubview(headerView)
        self.headerView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalToSuperview().offset(50)
            make.height.equalTo(67.adjustedHeight)
        }
        self.headerView.setHeaderView(HiddenMoreBtn: false, headerLabelText: "기록 상세보기")
        self.headerView.isHiddenUnderLine = true
        
        self.headerView.delegate = self
    }
    
    private func configureGenreView(){
        genreCollectionView.dataSource = self
        genreCollectionView.delegate = self
        genreCollectionView.register(GenreCollectionViewCell.nib(), forCellWithReuseIdentifier: GenreCollectionViewCell.identifier)
    }
}

extension RecordDetailViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenreCollectionViewCell.identifier, for: indexPath) as? GenreCollectionViewCell else { return UICollectionViewCell()}
        
        cell.configureCell(genreNumber: genres[indexPath.row], emotionNumber: dreamColor)
        return cell
    }
}

extension RecordDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //해시태그 길이 글자 크기에 맞추기
        let temporaryLabel = UILabel()
        temporaryLabel.text = "# \(Constant.Genre.IntType(genres[indexPath.row]).title)"
        return CGSize(width: temporaryLabel.intrinsicContentSize.width, height: 23)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
}

extension  RecordDetailViewController: NavigationBarDelegate {
    func navigationMoreButtonDidTap() {
        let recordDetailBottomSheet = RecordDetailBottomSheetViewController.instanceFromNib()
        recordDetailBottomSheet.modalPresentationStyle = .overFullScreen
        
        self.present(recordDetailBottomSheet, animated: false) {
            recordDetailBottomSheet.showBottomSheet()
        }
    }
    
    func navigationBackButtonDidTap() {
        
    }
}
