//
//  UserRegistrationViewModel.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Foundation

protocol UserRegistrationViewModelDelegate : class {
    func didFinishUserRegistration(with email: String)
}

final class UserRegistrationViewModel {
    
    private weak var delegate: UserRegistrationViewModelDelegate?
    
    private let userService: UserService
    init(userService: UserService, delegate: UserRegistrationViewModelDelegate? = nil) {
        self.userService = userService
        self.delegate = delegate
    }
}
