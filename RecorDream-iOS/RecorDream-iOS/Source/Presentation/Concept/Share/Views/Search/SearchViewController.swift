//
//  SearchViewController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/18.
//

import UIKit

class SearchViewController: UIViewController {
    // MARK: - Properties
    private let searchView = SearchView()
    private var listDataSource: UITableViewDiffableDataSource<Search, Exist>!
    private var listSnapShot: NSDiffableDataSourceSnapshot<Search, Exist>!
    private var existSample = SearchResultExsit.existSampleData
    private var noneSample = SearchResultNone.noneSampleData
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - Extensions
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
