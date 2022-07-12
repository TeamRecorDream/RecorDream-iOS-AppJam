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
    case mainCardColorRed = "home_main_card_red"
    case mainCardColorBlue = "home_main_card_blue"
    case mainCardColorDark = "home_main_card_dark"
    case mainCardColorGreen = "home_main_card_green"
    case mainCardColorOrange = "home_main_card_orange"
    case mainCardColorPink = "home_main_card_pink"
    case mainCardColorPurple = "home_main_card_purple"
    
    var name: String {
        return self.rawValue
    }
}
