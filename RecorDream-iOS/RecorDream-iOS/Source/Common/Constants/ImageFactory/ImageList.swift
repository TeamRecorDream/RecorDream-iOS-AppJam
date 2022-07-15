//
//  Image.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/12.
//

import UIKit

enum ImageList: String, CaseIterable {
    case btnLogout = "btn_logout"
    case icnAllowBack = "icn_allow_back"
    case icnAllowForwardGray = "icn_allow_forward-gray"
    case icnAllowForwardWhite = "icn_allow_forward-white"
    case icnCalender = "icn_calender"
    case icnEdit = "icn_edit"
    case icnGallaryOn = "icn_gallary_on"
    case icnGalleryOff = "icn_gallery_off"
    case icnHome = "icn_home"
    case icnListOff = "icn_list_off"
    case icnListOn = "icn_list_on"
    case icnMic = "icn_mic"
    case icnMore = "icn_more"
    case icnMypage = "icn_mypage"
    case icnPeople = "icn_people"
    case icnPlay = "icn_play"
    case icnPlus = "icn_plus"
    case icnSearch = "icn_search"
    case icnStorage = "icn_storage"
    case rdLogoGrey = "rd_rogo_grey"
    case rdLogoPurple = "rd_rogo_purple"
    case buttonSaveOn = "record_btn_save_on"
    case buttonSaveOff = "recored_btn_save_off"
    case toggleOff = "toggle_off"
    case toggleOn = "toggle_on"
    
    // MARK: - main card 이미지
    case mainCardColorRed = "home_main_card_red"
    case mainCardColorBlue = "home_main_card_blue"
    case mainCardColorDark = "home_main_card_dark"
    case mainCardColorGreen = "home_main_card_green"
    case mainCardColorOrange = "home_main_card_orange"
    case mainCardColorPink = "home_main_card_pink"
    case mainCardColorPurple = "home_main_card_purple"
    case mainBackground = "main_background"
    
    // MARK: - emotion icon
    case emojiShy = "emoji_shy"
    case emojiShyOff = "emoji_shy_off"
    case emojiAngry = "emoji_angry"
    case emojiAngryOff = "emoji_angry_off"
    case emojiBlank = "emoji_blank"
    case emojiBlankOff = "emoji_blank_off"
    case emojiJoy = "emoji_joy"
    case emojiJoyOff = "emoji_joy_off"
    case emojiLove = "emoji_love"
    case emojiLoveOff = "emoji_love_off"
    case emojiSad = "emoji_sad"
    case emojiSadOff = "emoji_sad_off"
    case emojiShocked = "emoji_shocked"
    case emojiShockedOff = "emoji_shocked_off"
    case emojiAll = "emoji_all"
    case emojiAllOff = "emoji_all_off"
    
    // MARK: - 상세보기에 들어갈 배경
    case detailCardColorRed = "document_bg_red"
    case detailCardColorBlue = "document_bg_blue"
    case detailCardColorDark = "document_bg_dark"
    case detailCardColorGreen = "document_bg_green"
    case detailCardColorOrange = "document_bg_orange"
    case detailCardColorPink = "document_bg_pink"
    case detailCardColorPurple = "document_bg_purple"
    
    // MARK: - 기록하기 뷰에 들어갈 컬러셋
    case colorChipColorRed = "colorchip_red_on"
    case colorChipColorBlue = "colorchip_blue_on"
    case colorChipColorGreen = "colorchip_green_on"
    case colorChipColorOrange = "colorchip_orange_on"
    case colorChipColorPink = "colorchip_pink_on"
    case colorChipColorPurple = "colorchip_purple_on"
    
    var name: String {
        return self.rawValue
    }
}
