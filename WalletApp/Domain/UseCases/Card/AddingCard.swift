//
//  AddingCard.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 08/09/2023.
//

import Combine

protocol AddingCard {
    var cardGateway: CardGatewayType { get }
}

extension AddingCard  {
    func addCard(card: Card) -> Observable<Void> {
        cardGateway.addCard(card: card)
    }
}

