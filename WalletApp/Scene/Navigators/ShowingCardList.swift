//
//  ShowingProductList.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit
import SwiftUI

protocol ShowingCardList {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardList {
    func showCardList() {
        let view: CardsView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        vc.title = "Card List"
        navigationController.pushViewController(vc, animated: true)
    }
}
