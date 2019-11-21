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
        } else {
            hasError.onNext(false)
            errorMessage.onNext("")
            return
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
        
//        userService.verifyUser(email: email, token: token)
//            .receive(on: DispatchQueue.main)
//            .sink(
//            receiveCompletion: { [weak self] value in
//                guard let self = self else { return }
//                switch (value) {
//                case .failure(let error):
//                    print(error)
//                    self.showError = true
//                    self.errorMessage = "An error occurred"
//                case .finished:
//                    self.verified = true
//                }
//                }, receiveValue: { _ in })
//            .store(in: &disposables)
    }
}
