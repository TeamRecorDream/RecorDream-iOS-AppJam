//
//  SceneDelegate.swift
//  RecorDream-iOS
//
//  Created by 정은희 on 2022/07/06.
//

import UIKit

import HeeKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = HomeViewController()
        window?.backgroundColor = .black    // 에셋 추가 전 임시 설정
        window?.makeKeyAndVisible()
    }
}

