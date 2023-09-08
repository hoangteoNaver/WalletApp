//
//  ShowingAddCard.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit
import Combine
import SwiftUI

protocol ShowingAddCard {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingAddCard {
    func showAddCard() -> Driver<Void> {
        let delegate = PassthroughSubject<Void, Never>()
        let view: AddCardView = assembler.resolve(navigationController: navigationController, delegate: delegate)
        let vc = UIHostingController(rootView: view)
        navigationController.pushViewController(vc, animated: true)
        
        return delegate.eraseToAnyPublisher()
    }
}
