//
//  CardDetailView.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine
import SwiftUI

struct CardDetailView: View {
    @ObservedObject var output: CardDetailViewModel.Output
    
    
    private let viewModel: CardDetailViewModel
    private let loadTrigger = PassthroughSubject<Void,Never>()
    private let cancelBag = CancelBag()

    // MARK: GEOMETRY EFFECT
    //var animation: Namespace.ID
    // MARK: DELAY EXPENSE VIEW
    @State var showExpenseView: Bool = false
    
    var body: some View {
        VStack {
            CardView()
                //.matchedGeometryEffect(id: output.id) //, in: animation
                .frame(height: 200)
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        showExpenseView = false
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        withAnimation(.easeInOut(duration: 0.35)) {
                        }
                    }
                    
                }
                .zIndex(10)
            
            GeometryReader {proxy in
                let height = proxy.size.height + 50
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 20) {
                        //MARK: SHOW EXPENSES
                        //s
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .background(
                    Color.white
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .ignoresSafeArea()
                )
                .offset(y: showExpenseView ? 0 : height)
            }
            .padding([.horizontal, .top])
            .zIndex(-10)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        .background(Color("ColorBG").ignoresSafeArea())
        .onAppear {
            withAnimation(.easeInOut.delay(0.1)) {
                showExpenseView = true
            }
        }
    }
    
    @ViewBuilder
    func CardView()->some View {
        ZStack(alignment: .bottomLeading) {
            
            // MARKK - CARD BACKGROUND
            Image(output.cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            // MARK: - CARD DETAILS
            VStack(alignment: .leading, spacing: 10) {
                Text(output.name)
                    .fontWeight(.bold)
                
                Text(output.cardNumber.hideCardNumber())
                    .font(.callout)
                    .fontWeight(.bold)
            }
            .padding()
            .padding(.bottom, 10)
            .foregroundColor(.white)
        }
    }
    
    init(viewModel: CardDetailViewModel) {
        self.viewModel = viewModel
        let input = CardDetailViewModel.Input(loadTrigger: loadTrigger.asDriver())
        self.output = viewModel.transform(input, cancelBag: cancelBag)
        //self.animation = animation
        loadTrigger.send(())
    }
    
    
}

struct CardDetailView_Preview: PreviewProvider {
    static var previews: some View {
        Text("HAHA")
    }
}
