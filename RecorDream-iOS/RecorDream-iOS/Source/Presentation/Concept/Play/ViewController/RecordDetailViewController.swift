//
//  RecordDetailViewController.swift
//  RecorDream-iOS
//
//  Created by 임윤휘 on 2022/07/19.
//

import UIKit

class RecordDetailViewController: BaseViewController {
    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var tabPagerView: TabPagerView!
    @IBOutlet weak var emotionImage: UIImageView!
    @IBOutlet weak var cardView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    private var headerView = RecordHeaderView()
    //TODO: - 서버 연결 시 사용할 프로퍼티
    private var genres = [8, 4, 1]
    private var dreamColor = 1
    private var emotion = 2
    private var recordTitle = ""
    private var recordDate = ""
    var recordID: String? //TODO: - 화면 전환 시 기록 고유 번호 할당해주기
    var recordDetailData: RecordDetailModel?
//    var completionHandler: ((String) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestRecordDetail()
        popMypageView()
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
        configureGenreView()
        configureHeaderView()
    }
    
    private func configureView(){
        //self.emotionImage.image = UIImage(named: Constant.Emotion.IntType(emotion).title)
        //self.titleLabel.text = recordTitle
        //self.dateLabel.text = recordDate
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
    
    //MARK: - Action
    private func popMypageView() {
        self.headerView.backButton.addTarget(self, action: #selector(backButtonDidClicked), for: .touchUpInside)
    }
    
    @objc
    private func backButtonDidClicked() {
        print("backBtn")
        self.navigationController?.popViewController(animated: true)
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
        recordDetailBottomSheet.recordDetailData = recordDetailData
        
        self.present(recordDetailBottomSheet, animated: false) {
            recordDetailBottomSheet.showBottomSheet()
        }
    }
    
    func navigationBackButtonDidTap() {
        
    }
}

//MARK: - Network
extension RecordDetailViewController {
    private func requestRecordDetail() {
        guard let recordID = recordID else { return }
        RecordDetailService.shared.getRecordDetial(recordID: recordID, completionHandler: { [weak self] recordDetail in
            guard let self = self else { return }
            guard let recordDetail = recordDetail as? RecordDetailModel else { return }
            self.recordDetailData = recordDetail
            
//            self.completionHandler?(CreateRecordConst.recordId ?? "")
            print("\(recordDetail.emotion)")
            //self.emotion = recordDetail.emotion
//            self.dreamColor = recordDetail.dream_color
//            self.genres = recordDetail.genre
//            guard let content = recordDetail.content else {return}
//            guard let note = recordDetail.note else {return}
//            let contents = [content, note]
//            self.tabPagerView.contents = contents
            DispatchQueue.main.async {
                self.dreamColor = recordDetail.dream_color
                self.genres = recordDetail.genre
                self.genreCollectionView.reloadData()
                
                guard let content = recordDetail.content else {return}
                guard let note = recordDetail.note else {return}
                let contents = [content, note]
                self.tabPagerView.contents = contents
                self.tabPagerView.contentCollectionView.reloadData()
                
                self.emotionImage.image = UIImage(named: Constant.Emotion.IntType(recordDetail.emotion).title)
                self.titleLabel.text = recordDetail.title
                self.dateLabel.text = recordDetail.date
                self.cardView.image = UIImage(named: Constant.DetailBackgroundColor.IntType(self.dreamColor).title)
            }
            
            
        })
    }
}
