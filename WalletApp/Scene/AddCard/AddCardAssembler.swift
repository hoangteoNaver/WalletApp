//
//  AddCardAssembler.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit
import Combine

protocol AddCardAssembler {
    func resolve(navigationController: UINavigationController, delegate: PassthroughSubject<Void,Never> ) -> AddCardView
    func resolve(navigationController: UINavigationController, delegate: PassthroughSubject<Void,Never> ) -> AddCardViewModel
    func resolve(navigationController: UINavigationController) -> AddCardNavigatorType
    func resolve() -> AddCardUseCaseType
}

extension AddCardAssembler {
    func resolve(navigationController: UINavigationController, delegate: PassthroughSubject<Void,Never> ) -> AddCardView {
        return AddCardView(viewModel: resolve(navigationController: navigationController, delegate: delegate))
    }
    
    func resolve(navigationController: UINavigationController, delegate: PassthroughSubject<Void,Never>) -> AddCardViewModel {
        return AddCardViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            delegate: delegate
        )
    }
}

extension AddCardAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardNavigatorType {
        return AddCardNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddCardUseCaseType {
        return AddCardUseCase(cardGateway: resolve())
    }
}

extension AddCardAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> AddCardNavigatorType {
        return AddCardNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> AddCardUseCaseType {
        return AddCardUseCase(cardGateway: resolve())
    }
}
