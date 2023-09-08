//
//  Home.swift
//  WalletUI
//
//  Created by Shameem Reza on 13/3/22.
//

import SwiftUI
import Combine

struct CardsView: View {
    // MARK: - CARD ANIAMTION PROPERTIES
    @State var expandCards: Bool = false
    
    // MARK: TRANSACTION LIST PROPERTIES
    @State var currentCard: Card?
    @State var showDetailTransaction: Bool = false
    @Namespace var animation
    @ObservedObject var output: CardsViewModel.Output
    

    
    private let cancelBag = CancelBag()
    private let loadTrigger = PassthroughSubject<Void, Never>()
    private let addSelectTrigger = PassthroughSubject<Void, Never>()
    private let selectTrigger = PassthroughSubject<IndexPath, Never>()
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Wallet UI")
                .font(.largeTitle)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: expandCards ? .leading : .center)
                .padding(.horizontal)
                .overlay(alignment: .trailing) {
                    // MARK: CLOSE BUTTON
                    Button {
                        // MARK: CLOSE ON TOUCH
                        withAnimation(
                            .interactiveSpring(response: 0.8, dampingFraction: 0.7, blendDuration: 0.7)) {
                                expandCards = false
                            }
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .padding(10)
                            .background(.pink, in: Circle())
                    }
                    .offset(x: expandCards ? 10 : 15)
                    .opacity(expandCards ? 1 : 0)
                }
                .padding(.horizontal, 15)
                .padding(.bottom, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 0) {
                    // MARK: - CARD LIST
                                        
                    ForEach(Array(output.cards.enumerated()), id: \.offset) {index,card in
                        Group {
                                CardRowView(card: card, index: index, expandCards: $expandCards)
                                    .matchedGeometryEffect(id: card.id, in: animation)
                        }
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                print("AHJAJAJ")
                                selectTrigger.send(IndexPath(row: index , section: 0 ))
                            }
                        }
                    }
                }
                .overlay {
                    Rectangle()
                        .fill(.black.opacity(expandCards ? 0 : 0.01))
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.35)) {
                                expandCards = true
                            }
                        }
                }
                .padding(.top, expandCards ? 30 : 0)
                
            }
            .coordinateSpace(name: "SCROLL")
            .offset(y: expandCards ? 0 : 30)
            
            // MARK: ADD BUTTON
            Button {
                addSelectTrigger.send(())
                
            } label: {
                Image(systemName: "plus")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(.green, in: Circle())
            }
            .scaleEffect(expandCards ? 0.01 : 1)
            .opacity(!expandCards ? 1 : 0)
            .frame(height: expandCards ? 0 : nil)
            .padding(.bottom, expandCards ? 0 : 30)
        }
        .padding([.horizontal, .top])
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            //self.loadTrigger.send()
        }
    }
    
    init(viewModel: CardsViewModel) {
        let input = CardsViewModel.Input(
            loadTrigger: loadTrigger.eraseToAnyPublisher(),
            selectTrigger: selectTrigger.eraseToAnyPublisher(),
            addSelectTrigger: addSelectTrigger.eraseToAnyPublisher()
        )
        
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        self.loadTrigger.send(())
    }

}

extension String {
    func hideCardNumber() -> String {
        var newValue: String = ""
        let maxCount = self.count - 4
        
        self.enumerated().forEach {value in
            if value.offset >= maxCount {
                let string = String(value.element)
                newValue.append(contentsOf: string)
                
            } else {
                // MARK: - SHOW START
                let string = String(value.element)
                if string == " " {
                    newValue.append(contentsOf: " ")
                } else {
                    newValue.append(contentsOf: "*")
                }
            }
        }
        return newValue
    }
}
// MARK: - HIDE FIRST FEW DIGIT



struct CardsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel: CardsViewModel = PreviewAssembler().resolve(
            navigationController: UINavigationController()
        )
        
        return CardsView(viewModel: viewModel)
    }
}

