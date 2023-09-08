//
//  LoginNavigator.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol LoginNavigatorType {
    func showCardList()
}

struct LoginNavigator: LoginNavigatorType, ShowingCardList {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
}
