//
//  CardDetailViewModel.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine

struct CardDetailViewModel {
    let navigator: CardDetailNavigatorType
    let useCase: CardDetailUseCaseType
    let card: Card
}

// MARK: - ViewModel
extension CardDetailViewModel: ViewModel {
    struct Input {
        let loadTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var name = ""
        @Published var id = ""
        @Published var cardImage = ""
        @Published var cardNumber = ""
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let card = input.loadTrigger
            .map{self.card}
        let output = Output()
        
        card
            .map{$0.name}
            .assign(to: \.name, on: output)
            .store(in: cancelBag)
        
        card
            .map{$0.id}
            .assign(to: \.id, on: output)
            .store(in: cancelBag)
        
        card
            .map{$0.cardImage}
            .assign(to: \.cardImage, on: output)
            .store(in: cancelBag)
        
        card
            .map{$0.cardNumber}
            .assign(to: \.cardNumber, on: output)
            .store(in: cancelBag)
        return output
    }
}
