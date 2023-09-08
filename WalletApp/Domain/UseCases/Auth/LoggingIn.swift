//
//  LoggingIN.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine
import Foundation

protocol LoggingIn {
    var authGateway: AuthGatewayType { get }
}

extension LoggingIn {
    func login(email: String, password: String) -> Observable<Void> {
        return authGateway.login(email, password)
    }
}
