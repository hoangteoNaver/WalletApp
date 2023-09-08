//
//  LoginView.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import SwiftUI
import Combine

struct LoginView: View {
    @ObservedObject var input: LoginViewModel.Input
    @ObservedObject var output: LoginViewModel.Output
    
    private let cancelBag = CancelBag()
    private let loginTrigger = PassthroughSubject<Void, Never>()

    // MARK: - View
    var body: some View {
        VStack() {
            Text("Harry Potter Shop")
                .font(.largeTitle).foregroundColor(Color.black)
                .padding([.top, .bottom], 40)
            VStack(alignment: .leading, spacing: 15) {
                
                TextField("Email", text: self.$input.email)
                    .padding()
                    .cornerRadius(20.0)
                
                SecureField("Password", text: self.$input.password)
                    .padding()
                    .cornerRadius(20.0)
            }.padding([.leading, .trailing], 27.5)
            Button(action: {
                self.loginTrigger.send(())
            }) {
                Text("Sign In")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.green)
                    .cornerRadius(15.0)
            }
        }
    }
    
    init(viewModel: LoginViewModel)
    {
        let input = LoginViewModel.Input(loginTrigger: loginTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.input = input
    }
}

struct LoginView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel: LoginViewModel = PreviewAssembler().resolve(
            navigationController: UINavigationController()
        )
        
        return LoginView(viewModel: viewModel)
    }
}
