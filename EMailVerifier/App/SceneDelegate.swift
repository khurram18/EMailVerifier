//
//  SceneDelegate.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Apollo

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private let apolloUserService = ApolloUserService(apolloClient: ApolloClient(url: URL(string: "http://graphql.dev.rtw.team/query")!))
    
    private var navigationController: UINavigationController? {
        return window?.rootViewController as? UINavigationController
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let navigationConntroller = navigationController,
            let viewController = navigationConntroller.viewControllers.first as? UserRegistrationViewController else { return }
        
        viewController.viewModel = UserRegistrationViewModel(userService: apolloUserService, delegate: self)
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

extension SceneDelegate : UserRegistrationViewModelDelegate {
    func didFinishUserRegistration(with email: String) {
        let viewController = UIStoryboard.main.instantiateUserVerifyViewController()
        let viewModel = UserVerifyViewModel(email: email, userService: apolloUserService)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SceneDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is UserVerifyViewController {
            navigationController.viewControllers.remove(at: 0)
        }
    }
}
