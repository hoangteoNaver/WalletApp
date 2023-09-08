//
//  GettingCards.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine

protocol GettingCards {
    var cardGateway: CardGatewayType { get }
}

extension GettingCards  {
    func getCards() -> Observable<[Card]> {
        cardGateway.getCards()
    }
}
