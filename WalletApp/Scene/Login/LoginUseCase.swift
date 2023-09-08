//
//  LoginUseCase.swift
//  WalletDemo
//
//  Created by FVFH412VQ6L7 on 05/09/2023.
//

import Foundation

protocol LoginUseCaseType {
    func login(email: String, password: String) -> Observable<Void>
}

struct LoginUseCase: LoginUseCaseType, LoggingIn {
    let authGateway: AuthGatewayType
}
