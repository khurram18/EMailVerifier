//
//  MockService.swift
//  EMailVerifierTests
//
//  Created by Khurram Shehzad on 22/11/2019.
//

@testable import EMailVerifier

import RxSwift

import Foundation

final class MockError : Error {}

final class MockService : UserService {
    
    let email: String
    let password: String
    let token: String
    
    init(email: String, password: String, token: String) {
        self.email = email
        self.password = password
        self.token = token
    }
    
    func registerUser(email: String, password: String) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                if email == self.email && password == self.password {
                    observer.onNext(true)
                } else {
                    observer.onError(MockError())
                }
            }
            return Disposables.create()
        }
    }
    
    func verifyUser(email: String, token: String) -> Observable<Bool> {
        Observable<Bool>.create { observer in
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                if email == self.email && token == self.token {
                    observer.onNext(true)
                } else {
                    observer.onError(MockError())
                }
            }
            return Disposables.create()
        }
    }
}
