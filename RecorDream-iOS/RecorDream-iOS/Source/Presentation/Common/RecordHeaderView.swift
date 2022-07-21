//
//  RecordHeaderView.swift
//  RecorDream-iOS
//
//  Created by Sojin Lee on 2022/07/17.
//

import UIKit

import SnapKit
import Then

class RecordHeaderView: BaseView {
    // MARK: - Properties
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var moreButton: UIButton!
    var delegate: NavigationBarDelegate?
    var isHiddenUnderLine: Bool = false {
        didSet {
            self.underLineView.isHidden = isHiddenUnderLine
        }
    }
    
    override func setupView() {
        guard let headerView = UINib(nibName: "RecordHeaderView", bundle: nil).instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        headerView.frame = self.bounds
        self.addSubview(headerView)
        
        headerLabel.font = TypoStyle.menu1.font
    }
    
    // MARK: - @IBAction Properties
    @IBAction func moreButtonDidTap(_ sender: UIButton) {
        // TODO: - 윤휘언니의 더보기 버튼
        if let delegate = delegate {
            delegate.navigationMoreButtonDidTap()
        }
    }
    
    @IBAction func backButtonDidTap(_ sender: UIButton) {
        if let delegate = delegate {
            delegate.navigationBackButtonDidTap()
        }
    }
    
    // MARK: - Functions
    func setHeaderView(HiddenMoreBtn: Bool, headerLabelText: String) {
        moreButton.isHidden = HiddenMoreBtn
        headerLabel.text = headerLabelText
    }
}
