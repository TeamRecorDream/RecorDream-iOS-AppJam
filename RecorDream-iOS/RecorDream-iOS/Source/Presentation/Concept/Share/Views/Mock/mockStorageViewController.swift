//
//  mockStorageViewController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/21.
//

import UIKit

class mockStorageViewController: UIViewController {
    private let filterIconList = FilterIconList.dummy
    private let listCellDesign = ListCellDesign.dummy
    
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var gallaryStackView: UIStackView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var listViewImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
        registerNib()
        setupViews()
    }
    
    @IBAction func touchUpToSearchButton(_ sender: UIButton) {
        let searchViewController = SearchViewController.instanceFromNib()
        navigationController?.pushViewController(searchViewController, animated: false)
    }
    @IBAction func touchUpToMypageButton(_ sender: UIButton) {
        let mypageViewController = MyPageViewController.instanceFromNib()
        navigationController?.pushViewController(mypageViewController, animated: false)
    }
    @IBAction func touchUpToListButton(_ sender: UIButton) {
        gallaryStackView.isHidden = true
        listViewImage.isHidden = false
    }
}

extension mockStorageViewController {
    private func setupViews() {
        self.navigationController?.navigationBar.isHidden = true
    }
    private func registerNib() {
        let filterNib = UINib(nibName: FilterCollectionViewCell.nibName, bundle: nil)
        filterCollectionView.register(filterNib, forCellWithReuseIdentifier: FilterCollectionViewCell.reuseIdentifier)
        let listNib = UINib(nibName: SearchResultTableViewCell.nibName, bundle: nil)
        listTableView.register(listNib, forCellReuseIdentifier: SearchResultTableViewCell.reuseIdentifier)
    }
    func assignDelegation() {
        filterCollectionView.dataSource = self
        listTableView.dataSource = self
    }
}

extension mockStorageViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterIconList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let filterCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.reuseIdentifier, for: indexPath) as? FilterCollectionViewCell
        else { return UICollectionViewCell() }
        filterCell.setFilterIcon(data: filterIconList[indexPath.row])
        filterCell.filterButton.isSelected = false
        if filterCell.filterButton.isSelected {
            filterCell.filterButton.alpha = 1.0
            filterCell.filterButton.isSelected.toggle()
        } else { filterCell.filterButton.alpha = 0.35 }
        return filterCell
    }
}

extension mockStorageViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listCellDesign.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let listCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell
        else { return UITableViewCell() }
        listCell.setFilterIcon(data: listCellDesign[indexPath.row])
        return listCell
    }
}
