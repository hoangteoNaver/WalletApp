//
//  ShowingLogin.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import UIKit
import SwiftUI

protocol ShowingLogin {
    var assembler: Assembler { get }
    var navigationController: UINavigationController { get }
}

extension ShowingLogin {
    func showLogin() {
        let view: LoginView = assembler.resolve(navigationController: navigationController)
        let vc = UIHostingController(rootView: view)
        vc.title = "Login"
        navigationController.pushViewController(vc, animated: true)
    }
}
