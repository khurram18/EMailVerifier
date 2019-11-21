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
        window?.rootViewController as? UINavigationController
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let navigationConntroller = navigationController,
            let viewController = navigationConntroller.viewControllers.first as? UserRegistrationViewController else { return }
        
        navigationConntroller.delegate = self
        
        viewController.viewModel = UserRegistrationViewModel(userService: apolloUserService, delegate: self)
    }
}

extension SceneDelegate : UserRegistrationViewModelDelegate {
    func didFinishUserRegistration(with email: String) {
        let viewController = UIStoryboard.main.instantiateUserVerifyViewController()
        let viewModel = UserVerifyViewModel(email: email, userService: apolloUserService, delegate: self)
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
}

extension SceneDelegate: UserVerifyViewModelDelegate {
    func didFinishUserVerification() {
        navigationController?.pushViewController(UIStoryboard.main.instantiateUserVerifiedViewController(), animated: true)
    }
}
extension SceneDelegate: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is UserVerifyViewController || navigationController.viewControllers.first is UserVerifyViewController {
            navigationController.removeViewController(at: 0, animated: false)
        }
    }
}
