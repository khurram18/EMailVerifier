//
//  UserRegistrationViewModel.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxSwift
import Foundation

protocol UserRegistrationViewModelDelegate : class {
    func didFinishUserRegistration(with email: String)
}

final class UserRegistrationViewModel {
    
    // UI will update these
    var email : PublishSubject<String> = PublishSubject()
    var password: PublishSubject<String> = PublishSubject()
    
    // UI will subscribe to these
    var hasError : PublishSubject<Bool> = PublishSubject()
    var errorMessage : PublishSubject<String> = PublishSubject()

    var showLoading : PublishSubject<Bool> = PublishSubject()
    
    private weak var delegate: UserRegistrationViewModelDelegate?
    
    private let userService: UserService
    private let disposeBag = DisposeBag()
    private let throttleIntervalInMilliseconds = 500
    
    private var emailValue = ""
    private var passwordValue = ""
    
    init(userService: UserService, delegate: UserRegistrationViewModelDelegate? = nil) {
        self.userService = userService
        self.delegate = delegate
        initValues()
        setupObservers()
    }
    
    func onRegisterButtonTap() {
        
        if emailValue.isValidEmail {
            hasError.onNext(false)
            errorMessage.onNext("")
        } else {
            hasError.onNext(true)
            errorMessage.onNext("Please enter a valid email address")
            return
        }
        
        if passwordValue.isValidPassword {
            hasError.onNext(false)
            errorMessage.onNext("")
        } else {
            hasError.onNext(true)
            errorMessage.onNext("Password length must be at least 8 characters")
            return
        }
        
        performUserRegistration()
    }
    private func setupObservers() {
        email.asObserver()
            .throttle(.milliseconds(throttleIntervalInMilliseconds), scheduler: MainScheduler.instance)
            .subscribe(onNext: {value in
                self.emailValue = value
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
        
        password.asObserver()
            .throttle(.milliseconds(throttleIntervalInMilliseconds), scheduler: MainScheduler.instance)
            .subscribe(onNext: {value in
                self.passwordValue = value
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
    private func initValues() {
        hasError.onNext(false)
        errorMessage.onNext("")
        showLoading.onNext(false)
    }
    private func performUserRegistration() {
        showLoading.onNext(true)
        userService.registerUser(email: emailValue, password: passwordValue)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { success in
                if success {
                    self.showLoading.onNext(false)
                    self.hasError.onNext(false)
                    self.errorMessage.onNext("")
                    self.didFinishUserRegistration()
                }
            },
                       onError: { error in
                        self.showLoading.onNext(false)
                        self.hasError.onNext(true)
                        let message = (error as? GraphQLError)?.message ?? "An error occurred"
                        self.errorMessage.onNext(message)
            })
        .disposed(by: disposeBag)
    }
    
    private func didFinishUserRegistration() {
        delegate?.didFinishUserRegistration(with: emailValue)
    }
}
