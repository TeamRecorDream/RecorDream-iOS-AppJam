//
//  SearchViewModel.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import UIKit

// MARK: - Section
enum Search {
    case none
    case exist
}

struct None: Hashable {
    var userID: Int = 1
    var recordCount: Int = 0
    var records: [String] = [ ]
}
struct Exist: Hashable {
    var userID: Int = 1
    var recordCount: Int
    var records: [String]
}
