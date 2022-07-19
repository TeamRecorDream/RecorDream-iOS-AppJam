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
    
    // MARK: - View Life Cycle
    override func loadView() {
        view = searchView
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
