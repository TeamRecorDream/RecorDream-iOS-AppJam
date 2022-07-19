//
//  SearchResultDummyModel.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/19.
//

import UIKit

extension SearchResultNone {
    static let noneSampleData = MockParser.load([SearchResultNone].self, from: "dummySearchResultNone")
}
extension SearchResultExsit {
    static let existSampleData = MockParser.load([SearchResultExsit].self, from: "dummySearchResultExist")
}
