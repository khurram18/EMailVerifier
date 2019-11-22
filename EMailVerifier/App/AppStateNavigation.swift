//
//  AppStateNavigation.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 22/11/2019.
//

import Apollo
import RxSwift

import Foundation
import UIKit

final class AppStateNavigation: NSObject {
    
    private let apolloUserService = ApolloUserService(apolloClient: ApolloClient(url: URL(string: "http://graphql.dev.rtw.team/query")!))
    private let disposeBag = DisposeBag()
    private let window: UIWindow
    private var navigationController: UINavigationController? {
        window.rootViewController as? UINavigationController
    }
    
    init(window: UIWindow) {
        self.window = window
        super.init()
        
        guard let navigationConntroller = navigationController,
            let viewController = navigationConntroller.viewControllers.first as? UserRegistrationViewController else { return }
        
        navigationConntroller.delegate = self
        navigationController?.hero.isEnabled = true
        navigationController?.hero.navigationAnimationType = .fade
        configure(userRegistrationViewController: viewController)
    }
}

extension AppStateNavigation: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        if viewController is UserVerifyViewController || navigationController.viewControllers.first is UserVerifyViewController {
            navigationController.removeViewController(at: 0, animated: false)
        }
    }
}

extension AppStateNavigation {
    
    private func configure(userRegistrationViewController: UserRegistrationViewController) {
        
        let viewModel = UserRegistrationViewModel(userService: apolloUserService)
        
        var email = ""
        viewModel.email
            .asObserver()
            .subscribe(onNext: { value in
                email = value
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        viewModel.didFinishUserRegistration
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: nil, onError: nil, onCompleted: {
                self.didFinishUserRegistration(with: email)
            }, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewController.viewModel = viewModel
    }
    
    private func didFinishUserRegistration(with email: String) {
        let viewController = UIStoryboard.main.instantiateUserVerifyViewController()
        let viewModel = UserVerifyViewModel(email: email, userService: apolloUserService)
        
        viewModel.didFinishUserVerification
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: nil, onError: nil, onCompleted: {
                self.didFinishUserVerification()
            }, onDisposed: nil)
            .disposed(by: disposeBag)
        
        viewController.viewModel = viewModel
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func didFinishUserVerification() {
        let viewController = UIStoryboard.main.instantiateUserVerifiedViewController()
        viewController.title = "Account Verified"
        viewController.hero.isEnabled = true
        navigationController?.pushViewController(viewController, animated: true)
    }
}
