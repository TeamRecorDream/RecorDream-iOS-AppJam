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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        setRecorDreamView() // TODO: - 꿈 기록 여부에 따라 view 바꾸기
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
            make.leading.trailing.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setEmptyView(){
        view.addSubview(homeUserNameView)
        
        homeUserNameView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        homeUserNameView.setUserNameView(name : "소진", isEmpty:true) // TODO: - user name 넣기
    }
    
    func setRecorDreamView(){
        view.addSubview(recorDreamView)
        
        recorDreamView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        recorDreamView.setUserNameView(name: "소진 하이", isEmpty: false) // TODO: - user name 넣기
    }
}
