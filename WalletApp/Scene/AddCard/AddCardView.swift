//
//  AddCardView.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import SwiftUI
import FirebaseFirestore
import Combine
import FirebaseFirestoreSwift

struct AddCardView: View {
    
    @ObservedObject var output: AddCardViewModel.Output
    @FocusState private var activeRF: ActiveKeyboardField!
    @State private var cardNumber: String = ""
    @State private var cardHolderName: String = ""
    @State private var cvvCode: String = ""
    @State private var expireDate: String = ""
    
    private let addTrigger = PassthroughSubject<Card, Never>()

    private let cancelBag = CancelBag()
    
    var body: some View {
        CardView()
        
        Button {
            addTrigger.send(Card(name: cardHolderName, cardNumber: cardNumber, cardImage: "card\(Int.random(in: 1...4))"))
        } label: {
            Label("Add Card", systemImage: "lock")
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.vertical,12)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.blue.gradient)
                )
        }
    }
    
    @ViewBuilder
    func CardView()-> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .fill(.linearGradient(colors: [.red,.blue], startPoint: .topLeading, endPoint: .bottomTrailing))
            
            // --MARK: CARD DETAIL
            VStack(spacing: 10){
                HStack{
                    TextField("XXXX XXXX XXXX XXXX", text: .init(
                        get: {
                            cardNumber
                        }, set: {
                            value in
                            cardNumber = ""
                            let startIndex = value.startIndex
                            for index in 0..<value.count {
                                let stringIndex = value.index(startIndex, offsetBy: index)
                                cardNumber += String(value[stringIndex])
                                if (index + 1) % 5 == 0 && value[stringIndex] != " "{
                                    cardNumber.insert(" ",at: stringIndex)
                                }
                            }
                            
                            if value.last == " " {
                                cardNumber.removeLast()
                            }
                            
                            cardNumber = String(cardNumber.prefix(19))
                        }
                    ))
                    .font(.title3)
                    .keyboardType(.numberPad)
                    .focused($activeRF, equals: .cardNumber)
                    
                    Spacer(minLength: 0)
                    
                    Image("card1")
                        .resizable()
                        .renderingMode(.template)
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 50)
                }
                
                HStack(spacing: 12) {
                    TextField("MM/YY", text: .init(get: {
                        expireDate
                    }, set: { value in
                        
                        if value.count == 3 && !value.contains("/") {
                            let startIndex = value.startIndex
                            let thirdPosition = value.index(startIndex, offsetBy: 2)
                            expireDate.insert("/", at: thirdPosition)
                        }
                        
                        if value.last == "/"
                        {
                            expireDate.removeLast()
                        }
                        
                        expireDate = String(expireDate.prefix(5))
                    }))
                    .keyboardType(.numberPad)
                    .focused($activeRF, equals: .expirationDate)
                    
                    Spacer(minLength: 10)
                    
                    TextField("CVV", text: .init(get: {
                        cvvCode
                    }, set: { value in
                        cvvCode = String(cvvCode.prefix(5))
                    }))
                    .frame(width: 35)
                    .focused($activeRF, equals: .cvv)
                    .keyboardType(.numberPad)
                    
                    Image(systemName: "questionmark.circle.fill")
                }
                
                .padding(.top,15)
                
                Spacer(minLength: 0)
                
                TextField("CARD HOLDER NAME", text: $cardHolderName)
                    .focused($activeRF, equals: .cardHolderName)
            }
            .padding(20)
            .tint(.white)
        }
        .frame(height: 200)
        .padding(.top, 35)
    }
    
    
    init(viewModel: AddCardViewModel) {
        let input = AddCardViewModel.Input(addTrigger: addTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
    }
}

struct AddCardView_Preview: PreviewProvider {
    static var previews: some View {
        let viewModel: AddCardViewModel = PreviewAssembler().resolve(
            navigationController: UINavigationController(),
            delegate: PassthroughSubject<Void, Never>()
        )
        
        return AddCardView(viewModel: viewModel)
    }
}
