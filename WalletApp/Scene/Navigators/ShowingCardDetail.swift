//
//  ShowingCardDetail.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit
import SwiftUI

protocol ShowingCardDetail {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingCardDetail {
    func showCardDetail(card: Card) {
        let view: CardDetailView = assembler.resolve(navigationController: navigationController, card: card)
        let vc = UIHostingController(rootView: view)
        vc.title = "Card Detail"
        navigationController.pushViewController(vc, animated: true)
    }
}
