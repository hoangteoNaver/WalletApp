//
//  CardsNavigator.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol CardsNavigatorType {
    func showCardDetail(card: Card)
    func showAddCard() -> Driver<Void>
}

struct CardsNavigator: CardsNavigatorType, ShowingCardDetail, ShowingAddCard {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
