//
//  UserRegistrationTests.swift
//  EMailVerifierTests
//
//  Created by Khurram Shehzad on 22/11/2019.
//

import RxSwift
import XCTest

@testable import EMailVerifier

class UserRegistrationTests: XCTestCase {

    private var userRegistrationViewModel: UserRegistrationViewModel?
    private let disposeBag = DisposeBag()
    
    let email = "abc@xyz.com"
    let password = "qwer1234"
    let token = "xyz"
    
    override func setUp() {
        let mockService = MockService(email: email, password: password, token: token)
        userRegistrationViewModel = UserRegistrationViewModel(userService: mockService)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testUserRegistrationEmptyEmail() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.email.onNext("")
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserRegistrationWrongEmail() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.email.onNext("abc")
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserRegistrationEmptyPassword() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.password.onNext("")
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserRegistrationWrongPassword() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.password.onNext("123")
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserRegistrationCorrectEmailAndPassword() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value == false {
                    expectation.fulfill()
                }
                
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.email.onNext("abc@xyz.com")
        userRegistrationViewModel?.password.onNext("qwer1234")
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testUserRegistrationCorrectResponse() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.didFinishUserRegistration
            .asObservable()
            .observeOn(MainScheduler.init())
            .subscribe(onNext: nil, onError: nil, onCompleted: {
                print("\(expectation.expectationDescription)")
                expectation.fulfill()
            }, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.email.onNext(email)
        userRegistrationViewModel?.password.onNext(password)
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testUserRegistrationWrongResponse() {
        
        let expectation = defaultExpectation()
        
        userRegistrationViewModel?.hasError
            .asObserver()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { value in
                if value == false {
                    expectation.fulfill()
                }
            }, onError: nil, onCompleted: nil, onDisposed: nil)
            .disposed(by: disposeBag)
        
        userRegistrationViewModel?.email.onNext("qwer@qwer.com")
        userRegistrationViewModel?.password.onNext(password)
        userRegistrationViewModel?.onRegisterButtonTap()
        waitForExpectations(timeout: 1, handler: nil)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
