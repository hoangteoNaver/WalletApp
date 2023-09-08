//
//  CardsUseCase.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine

protocol CardsUseCaseType {
    func getCards() -> Observable<[Card]>
}

struct CardsUseCase: CardsUseCaseType, GettingCards {
    let cardGateway: CardGatewayType
}
