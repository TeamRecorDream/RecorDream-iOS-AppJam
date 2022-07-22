//
//  TabBarController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/16.
//

import UIKit

import HeeKit
import SnapKit
import Then

final class TabBarController: UITabBarController {
    // MARK: - Properties
    private lazy var emptyViewController = UIViewController()
    private lazy var tabs: [UIViewController] = [ ]
    private lazy var recordButton = UIButton().then {
        $0.setBackgroundImage(ImageList.icnRecord.image, for: .normal)
        $0.addTarget(self,
                     action: #selector(presentRecordView),
                     for: .touchUpInside
        )
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraint()
        setTabBarItems()
        setTabBarAppearance()
        setTabBarFrame()
        setTargets()
    }
}

// MARK: - Extensions
extension TabBarController: Presentable {
    internal func setupView() {
        self.tabBar.addSubview(recordButton)
        self.delegate = self
    }
    
    internal func setupConstraint() {
        self.recordButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(tabBar.snp.top)
        }
    }
    
    private func setTargets() {
        self.recordButton.addTarget(self,
                                    action: #selector(presentRecordView),
                                    for: .touchUpInside)
    }
    
    @objc
    private func presentRecordView() {
        let recordViewController = RecordViewController()
        recordViewController.modalPresentationStyle = .fullScreen
        self.present(recordViewController, animated: false)
    }
    
    private func setTabBarItems() {
        tabs = [
            UINavigationController(rootViewController: HomeViewController()),
            UINavigationController(rootViewController: emptyViewController),
            UINavigationController(rootViewController: mockStorageViewController.instanceFromNib())
        ]
        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
            tabs[$0.rawValue].tabBarItem.imageInsets = UIEdgeInsets(
                top: 0, left: 0, bottom: -14, right: 0
            )
        }
        self.setViewControllers(tabs, animated: false)
    }
    
    private func setTabBarAppearance() {
        UITabBar.appearance().backgroundColor = .clear
        UITabBar.appearance().tintColor = .white
        UITabBar.appearance().unselectedItemTintColor = .white
    }

    private func setTabBarFrame() {
        tabBar.frame.size.height = 106.adjustedHeight
        tabBar.frame.origin.y = view.frame.height - 9.adjustedHeight
        let customTabBar = UIImageView(image: ImageList.icnTabBarBackGround.image)
        customTabBar.frame = self.tabBar.bounds
        tabBar.addSubview(customTabBar)
        tabBar.sendSubviewToBack(customTabBar)
        tabBar.bringSubviewToFront(recordButton)
        tabBar.isTranslucent = true
        tabBar.itemSpacing = 67.adjustedWidth
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let tabBarItemIndex = viewController.tabBarItem.tag
        switch tabBarItemIndex {
        case 1:
            tabBarItem.isEnabled = false
            return false
        default:
            tabBarItem.isEnabled = true
        }
        return true
    }
}
