//
//  UserVerifyViewModel.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Foundation

final class UserVerifyViewModel : ObservableObject {
    
//    @Published var email: String = ""
//    @Published var token: String = ""
//
//    @Published var verified = false
//    @Published var showLoading = false
//
//    @Published var showError = false
//    @Published var errorMessage = ""
    
    private let userService: UserService
//    private var disposables = Set<AnyCancellable>()
    
    init(email: String, userService: UserService) {
//        self.email = email
        self.userService = userService
    }
    
    func onVerifyButtonTap() {
//        if token.isEmpty {
//            showError = true
//            errorMessage = "Token cannot be empty"
//            return
//        }
//        showError = false
//        errorMessage = ""
        performEmailVerificatio()
    }
    private func performEmailVerificatio() {
//        showLoading = true
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
