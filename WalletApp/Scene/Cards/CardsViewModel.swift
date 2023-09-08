//
//  CardsViewModel.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Foundation
import Combine

struct CardsViewModel {
    let navigator: CardsNavigatorType
    let useCase: CardsUseCaseType
}

extension CardsViewModel: ViewModel{
    
    struct Input {
        let loadTrigger: Driver<Void>
        let selectTrigger: Driver<IndexPath>
        let addSelectTrigger: Driver<Void>
    }
    
    final class Output: ObservableObject {
        @Published var cards = [Card]()
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        let loadTriggerFromSelect = PassthroughSubject<Void, Never>()

        Publishers.Merge(input.loadTrigger, loadTriggerFromSelect)
            .map { _ in
                self.useCase.getCards()
                    .asDriver()
            }
            .switchToLatest()
            .assign(to: \.cards, on: output)
            .store(in: cancelBag)
        
        input.addSelectTrigger
            .flatMap{
                navigator.showAddCard()
                    .eraseToAnyPublisher()
            }
            .handleEvents(receiveOutput: { delegate
                in
                loadTriggerFromSelect.send(())
            })
            .sink()
            .store(in: cancelBag)
        
        input.selectTrigger
            .sink(receiveValue: {
                indexPath in
                let card = output.cards[indexPath.row]
                self.navigator.showCardDetail(card: card)
            })
            .store(in: cancelBag)
        return output
    }
    
    
}
