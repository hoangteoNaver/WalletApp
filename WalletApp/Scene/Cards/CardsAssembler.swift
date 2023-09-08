//
//  CardsAssembler.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol CardsAssembler {
    func resolve(navigationController: UINavigationController) -> CardsView
    func resolve(navigationController: UINavigationController) -> CardsViewModel
    func resolve(navigationController: UINavigationController) -> CardsNavigatorType
    func resolve() -> CardsUseCaseType
}

extension CardsAssembler {
    func resolve(navigationController: UINavigationController) -> CardsView {
        return CardsView(viewModel: resolve(navigationController: navigationController))
    }
    
    func resolve(navigationController: UINavigationController) -> CardsViewModel {
        return CardsViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension CardsAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CardsNavigatorType {
        return CardsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CardsUseCaseType {
        return CardsUseCase(cardGateway: CardGateway())
    }
}

extension CardsAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CardsNavigatorType {
        return CardsNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CardsUseCaseType {
        return CardsUseCase(cardGateway: CardGateway())
    }
}
