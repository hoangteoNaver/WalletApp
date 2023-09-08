//
//  AddCardUseCase.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine

protocol AddCardUseCaseType {
    func addCard(card: Card) -> Observable<Void>
}

struct AddCardUseCase: AddCardUseCaseType, AddingCard {
    let cardGateway: CardGatewayType
}
