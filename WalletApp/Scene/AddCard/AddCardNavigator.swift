//
//  AddCardNavigator.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit

protocol AddCardNavigatorType {
    func popPreviousView(animated: Bool)
}

struct AddCardNavigator: AddCardNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func popPreviousView(animated: Bool) {
        navigationController.popViewController(animated: animated)
    }
}
