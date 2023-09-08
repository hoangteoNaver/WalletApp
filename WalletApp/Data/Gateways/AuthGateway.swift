//
//  AuthGateway.swift
//  WalletDemo
//
//  Created by FVFH412VQ6L7 on 05/09/2023.
//

import Combine
import Foundation

import FirebaseAuth

protocol AuthGatewayType {
    func login(_ email: String,_ password: String) -> Observable<Void>
}

struct AuthGateway: AuthGatewayType {
    func login(_ email: String,_ password: String) -> Observable<Void> {
        return Future { promise in
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let error = error {
                    print("Failure")
                    promise(.success(()))
                    //promise(.failure(error))
                }
                else {
                    print("Success")

                    promise(.success(()))
                }
            }
        }
        .eraseToAnyPublisher()
    }
}
