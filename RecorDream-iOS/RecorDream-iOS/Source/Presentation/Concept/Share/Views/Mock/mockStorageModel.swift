//
//  mockStorageModel.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/22.
//

import UIKit

struct FilterIconList {
    let emotion: String
}

struct ListCellDesign {
    let emotion: String
    let date: String
    let description: String
}

// MARK: - Extensions
extension FilterIconList {
    static let dummy: [FilterIconList] = [
        FilterIconList(emotion: ImageList.emojiAll.name), FilterIconList(emotion: ImageList.emojiJoy.name),
        FilterIconList(emotion: ImageList.emojiShocked.name), FilterIconList(emotion: ImageList.emojiLove.name),
        FilterIconList(emotion: ImageList.emojiShy.name), FilterIconList(emotion: ImageList.emojiSad.name),
        FilterIconList(emotion: ImageList.emojiAngry.name)
    ]
}
extension ListCellDesign {
    static let dummy: [ListCellDesign] = [
    ListCellDesign(emotion: ImageList.emojiJoy.name, date: "2022년 6월 26일", description: "감자튀김이랑 놀이공원에 갔는데 어쩌 고저쩌고 하하하하 "),
    ListCellDesign(emotion: ImageList.emojiJoy.name, date: "2022년 7월 12일", description: "큐어를 봤다! 재개봉 해서 극장에서 봄ㅎㅎㅎ"),
    ListCellDesign(emotion: ImageList.emojiJoy.name, date: "2022년 7월 26일", description: "감자튀김이랑 길을 걸었다!! 신기하고 재밌는 꿈"),
    ListCellDesign(emotion: ImageList.emojiJoy.name, date: "2022년 8월 6일", description: "그냥 신났음"),
    ListCellDesign(emotion: ImageList.emojiJoy.name, date: "2022년 12월 20일", description: "크리스마스 파티를 했다~")
    ]
}
