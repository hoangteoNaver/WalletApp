//
//  LoginViewModel.swift
//  WalletDemo
//
//  Created by FVFH412VQ6L7 on 05/09/2023.
//

import Foundation


struct LoginViewModel {
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
}


extension LoginViewModel: ViewModel{
    final class Input: ObservableObject{
        @Published var email = ""
        @Published var password = ""
        let loginTrigger: Driver<Void>
        
        init(loginTrigger: Driver<Void>)
        {
            self.loginTrigger = loginTrigger
        }
        
    }
    
    final class Output: ObservableObject {
        @Published var isLoggined = false
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.loginTrigger
            .map { _ in
                self.useCase.login(email: input.email, password: input.password)
                    .asDriver()
            }
            .switchToLatest()
            .sink(receiveValue: {
                self.navigator.showCardList()
            })
            .store(in: cancelBag)

        return output
    }
}
