//
//  CardDetailNavigator.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol CardDetailNavigatorType {
    
}

struct CardDetailNavigator: CardDetailNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
