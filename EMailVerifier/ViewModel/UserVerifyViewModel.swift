//
//  UserVerifyViewModel.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxSwift

import Foundation

protocol UserVerifyViewModelDelegate : class {
    func didFinishUserVerification()
}

final class UserVerifyViewModel : ObservableObject {

    // UI will update these
    var token : PublishSubject<String> = PublishSubject()
    
    // UI will subscribe to these
    var hasError : PublishSubject<Bool> = PublishSubject()
    var errorMessage : PublishSubject<String> = PublishSubject()

    var showLoading : PublishSubject<Bool> = PublishSubject()
    
    private let userService: UserService
    private let email: String
    private let disposeBag = DisposeBag()
    private let throttleIntervalInMilliseconds = 500
    
    private var tokenValue = ""
    
    private weak var delegate: UserVerifyViewModelDelegate?
    
    init(email: String, userService: UserService, delegate: UserVerifyViewModelDelegate?) {
        self.email = email
        self.userService = userService
        self.delegate = delegate
        initValues()
        setupObservers()
    }
    
    func onVerifyButtonTap() {
        if tokenValue.isEmpty {
            hasError.onNext(true)
            errorMessage.onNext("Please enter token")
            return
        } else {
            hasError.onNext(false)
            errorMessage.onNext("")
        }
        performEmailVerification()
    }
    private func setupObservers() {
        token.asObserver()
            .throttle(.milliseconds(throttleIntervalInMilliseconds), scheduler: MainScheduler.instance)
            .subscribe(onNext: {value in
                if value.isEmpty {
                    self.tokenValue = ""
                    self.hasError.onNext(true)
                    self.errorMessage.onNext("Please enter token")
                } else {
                    self.tokenValue = value
                    self.hasError.onNext(false)
                    self.errorMessage.onNext("")
                }
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        .disposed(by: disposeBag)
    }
    private func initValues() {
        hasError.onNext(false)
        errorMessage.onNext("")
        showLoading.onNext(false)
    }
    private func performEmailVerification() {
        
        showLoading.onNext(true)
        userService.verifyUser(email: email, token: tokenValue)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { success in
                if success {
                    self.showLoading.onNext(false)
                    self.hasError.onNext(false)
                    self.errorMessage.onNext("")
                    self.didFinishUserVerification()
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
    
    private func didFinishUserVerification() {
        delegate?.didFinishUserVerification()
    }
}
