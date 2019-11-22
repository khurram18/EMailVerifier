//
//  ApolloUserService.swift
//  EMailVerifier
//
//  Created by Khurram Shehzad on 21/11/2019.
//

import Apollo
import RxSwift

import Foundation

final class ApolloUserService {
    
    let apolloClient: ApolloClient
    
    init(apolloClient: ApolloClient) {
        self.apolloClient = apolloClient
    }
    
}

extension ApolloUserService: UserService {
    
    func registerUser(email: String, password: String) -> Observable<Bool> {
        
        Observable<Bool>.create { observer in
            self.apolloClient.perform(mutation: UserRegistrationMutation(email: email, password: password)) { result in
                switch result {
                case .success(let response):
                    guard let data = response.data else {
                        observer.onError(GraphQLError(message: "An error occurred"))
                        return
                    }
                    guard data.userRegistration.status == .success else {
                        observer.onError(GraphQLError(message: data.userRegistration.message ?? "An error occurred"))
                        return
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func verifyUser(email: String, token: String) -> Observable<Bool> {
        
        Observable<Bool>.create { observer in
            
            self.apolloClient.perform(mutation: UserVerifyEmailMutation(email: email, token: token)) { result in
                switch result {
                case .success(let response):
                    guard let data = response.data else {
                        observer.onError(GraphQLError(message: "An error occurred"))
                        return
                    }
                    guard data.userVerifyEmail.status == .success else {
                        var message = data.userVerifyEmail.message ?? "An error occurred"
                        // FIXME: There is bug in backend that returns empty message in case of failure
                        if message.isEmpty {
                            message = "An error occurred"
                        }
                        observer.onError(GraphQLError(message: message))
                        return
                    }
                    observer.onNext(true)
                    observer.onCompleted()
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
