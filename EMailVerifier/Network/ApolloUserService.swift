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
        return perform(mutation: UserRegistrationMutation(email: email, password: password))
    }
    
    func verifyUser(email: String, token: String) -> Observable<Bool> {
        return perform(mutation: UserVerifyEmailMutation(email: email, token: token))
    }
    private func perform<Mutation: GraphQLMutation>(mutation: Mutation) -> Observable<Bool> {
        
        return Observable<Bool>.create { observer in

            self.apolloClient.perform(mutation: mutation) { result in
                switch result {
                case .success(_):
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
