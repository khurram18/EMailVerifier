//
//  UserVerifyViewModel.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxSwift

import Foundation

final class UserVerifyViewModel : ObservableObject {

    let email: String
    
    // UI will update this
    var token : PublishSubject<String> = PublishSubject()
    
    // UI will subscribe to these
    var hasError : PublishSubject<Bool> = PublishSubject()
    var errorMessage : PublishSubject<String> = PublishSubject()

    var showLoading : PublishSubject<Bool> = PublishSubject()
    var didFinishUserVerification: Observable<Void> {
        return finish.asObserver()
    }
    
    private var finish : PublishSubject<Void> = PublishSubject()
    
    private let userService: UserService
    private let disposeBag = DisposeBag()
    private let throttleIntervalInMilliseconds = 500
    
    private var tokenValue = ""
    
    init(email: String, userService: UserService) {
        self.email = email
        self.userService = userService
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
                self.tokenValue = value
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
                    self.didFinishVerification()
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
    
    private func didFinishVerification() {
        finish.onNext(Void())
    }
}
