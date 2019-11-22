//
//  UserVerificationTests.swift
//  EMailVerifierTests
//
//  Created by Khurram Shehzad on 22/11/2019.
//

import RxSwift
import XCTest

@testable import EMailVerifier

class UserVerificationTests: XCTestCase {

    private var userVerifyViewModel: UserVerifyViewModel?
    private let disposeBag = DisposeBag()
    
    private let email = "abc@xyz.com"
    private let password = "qwer1234"
    private let token = "xyz"
    
    override func setUp() {
        let mockService = MockService(email: email, password: password, token: token)
        userVerifyViewModel = UserVerifyViewModel(email: email, userService: mockService)
    }

    func testUserVerifyEmptyToken() {
        
        let expectation = defaultExpectation()
        
        userVerifyViewModel?.hasError
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        userVerifyViewModel?.token.onNext("")
        userVerifyViewModel?.onVerifyButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserVerifyWrongToken() {
        
        let expectation = defaultExpectation()
        print("expectation.expectationDescription:\(expectation.expectationDescription)")
        userVerifyViewModel?.hasError
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        userVerifyViewModel?.token.onNext("fasf")
        userVerifyViewModel?.onVerifyButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserVerifyCorrectToken() {
        
        let expectation = defaultExpectation()
        print("expectation.expectationDescription:\(expectation.expectationDescription)")
        userVerifyViewModel?.hasError
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value == false {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        userVerifyViewModel?.token.onNext("xyz")
        userVerifyViewModel?.onVerifyButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserVerifyCorrectResponse() {

        let expectation = defaultExpectation()

        userVerifyViewModel?.didFinishUserVerification
            .asObservable()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: nil, onError: nil, onCompleted: {
                expectation.fulfill()
            }, onDisposed: nil)
            .disposed(by: disposeBag)
        userVerifyViewModel?.token.onNext("xyz")
        userVerifyViewModel?.onVerifyButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
}
