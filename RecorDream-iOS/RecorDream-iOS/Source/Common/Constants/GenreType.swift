//
//  GenreType.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/15.
//

import Foundation

extension Constant {
    enum Genre {
        static let genreTitles = ["코미디" , "로맨스", "액션", "스릴러", "미스터리", "공포", "SF", "판타지", "가족/친구", "기타"]
        
        case IntType(Int)
        
        var title: String {
            switch self {
            case .IntType(let i):
                return Genre.genreTitles[i < Genre.genreTitles.count ? i : 0]
            }
        }
    }
}
