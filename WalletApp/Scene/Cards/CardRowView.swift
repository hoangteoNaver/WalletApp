//
//  CardRowView.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import SwiftUI

struct CardRowView: View {
    var card: Card
    var index: Int
    @Binding var expandCards: Bool
    var body: some View {
        GeometryReader {proxy in
            
            let rect = proxy.frame(in: .named("SCROLL"))
            let offset = CGFloat(index * (expandCards ? 10 : 70))
            
            ZStack(alignment: .bottomLeading) {
                
                // MARKK - CARD BACKGROUND
                Image(card.cardImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // MARK: - CARD DETAILS
                VStack(alignment: .leading, spacing: 10) {
                    Text(card.name)
                        .fontWeight(.bold)
                    
                    Text((card.cardNumber.hideCardNumber()))
                        .font(.callout)
                        .fontWeight(.bold)
                }
                .padding()
                .padding(.bottom, 10)
                .foregroundColor(.white)
            }
            .offset(y: expandCards ? offset: -rect.minY + offset)
        }
        .frame(height: 200)
        .padding(.horizontal)
    }
}

struct CardRowView_Previews: PreviewProvider {
    static var previews: some View {
        CardRowView(card: cards[0], index: 0, expandCards: .constant(false))
    }
}
