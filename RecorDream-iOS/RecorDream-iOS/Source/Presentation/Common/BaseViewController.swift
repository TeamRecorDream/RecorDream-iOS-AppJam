//
//  BaseViewController.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/07.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setHierarchy()
        setNavigation()
        setTargets()
    }
    
    func setHierarchy() { }
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    func setTargets() { }
}
