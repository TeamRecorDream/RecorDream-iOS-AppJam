//
//  SearchViewController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

class SearchViewController: BaseViewController {
    // MARK: - Properties
    private let searchView = SearchView()
    private var searchedCount: Int = 0
    private var searchedLists: [SearchExist] = []
    private let searchManager: ShareServiceable = ShareService(apiService: ShareAPIManager(), environment: .development)
//    private var listDataSource: UITableViewDiffableDataSource<Search, Exist>!
//    private var listSnapShot: NSDiffableDataSourceSnapshot<Search, Exist>!
//    private var existSample = SearchResultExsit.existSampleData
//    private var noneSample = SearchResultNone.noneSampleData
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = self.searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
    }
    
    override func setTargets() {
        self.searchView.navigationBarView.backButton.addTarget(
            self,
            action: #selector(backToStorageView),
            for: .touchUpInside)
    }
}

extension SearchViewController {
    private func assignDelegation() {
        self.searchView.searchTextField.delegate = self
        self.searchView.searchResultTableView.dataSource = self
    }
    @objc
    private func backToStorageView() {
        self.navigationController?.popViewController(animated: true)
    }
    func getSearchingKeyword(keyword: String) {
        Task {
            do {
                let lists = try await searchManager.getSearchingKeyword(keyword: keyword)
                if let lists = lists {
                    print("1111")
                }
            }
        }
    }
}

extension SearchViewController: UITextFieldDelegate, UITableViewDataSource {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            getSearchingKeyword(keyword: textField.text ?? "")
            searchView.searchResultLabel.isHidden = false
            searchView.searchResultImage.isHidden = false
            return true
        }
        else {
            self.searchView.searchResultTableView.searchEmptyView(message: "")
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
//        return searchedLists.recordsCount
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let searchResultCell = searchView.searchResultTableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell
        else { return UITableViewCell() }
        searchResultCell.selectionStyle = .none
        searchResultCell.dateLabel?.text = searchedLists[indexPath.row].date
        // TODO: - cell에 데이터 넣기
        return searchResultCell
    }
}


// TODO: - DiffableDataSource
//extension SearchViewController {
//    func setDataSource() {
//        listDataSource = UITableViewDiffableDataSource<Search, Exist>(
//            tableView: self.searchView.searchResultTableView,
//            cellProvider: {
//                (tableView: UITableView, indexPath: IndexPath, itemIdentifier: Exist) in
//                guard let listCell = tableView.dequeueReusableCell(withIdentifier: SearchResultTableViewCell.reuseIdentifier, for: indexPath) as? SearchResultTableViewCell
//                else { return UITableViewCell() }
//                return listCell
//            }
//        )
//        listSnapShot = NSDiffableDataSourceSnapshot<Search, Exist>()
//        listSnapShot.appendSections([.exist])
//        listSnapShot.appendItems(existSample, toSection: .exist)
//
//        listDataSource.apply(listSnapShot, animatingDifferences: true) { [weak self] in
//            // TODO: - 상세보기로 화면 전환
//        }
//    }
//}
