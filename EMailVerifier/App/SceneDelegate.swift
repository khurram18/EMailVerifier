//
//  SceneDelegate.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Apollo

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    private var appStateNavigation: AppStateNavigation?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let window = window else { return }
        
        appStateNavigation = AppStateNavigation(window: window)
    }
}
