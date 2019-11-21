//
//  UserService.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import RxSwift
import Foundation

protocol UserService {
    func registerUser(email: String, password: String) -> Observable<Bool>
    func verifyUser(email: String, token: String) -> Observable<Bool>
}
