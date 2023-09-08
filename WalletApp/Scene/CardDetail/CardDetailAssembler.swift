//
//  CardDetailAssembler.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol CardDetailAssembler {
    func resolve(navigationController: UINavigationController, card: Card) -> CardDetailView
    func resolve(navigationController: UINavigationController, card: Card) -> CardDetailViewModel
    func resolve(navigationController: UINavigationController) -> CardDetailNavigatorType
    func resolve() -> CardDetailUseCaseType
}

extension CardDetailAssembler {
    func resolve(navigationController: UINavigationController, card: Card) -> CardDetailView {
        CardDetailView(viewModel: resolve(navigationController: navigationController, card: card))
    }
    
    func resolve(navigationController: UINavigationController, card: Card) -> CardDetailViewModel {
        CardDetailViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve(),
            card: card
        )
    }
}

extension CardDetailAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> CardDetailNavigatorType {
        CardDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CardDetailUseCaseType {
        CardDetailUseCase()
    }
}

extension CardDetailAssembler where Self: PreviewAssembler {
    func resolve(navigationController: UINavigationController) -> CardDetailNavigatorType {
        CardDetailNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> CardDetailUseCaseType {
        CardDetailUseCase()
    }
}
