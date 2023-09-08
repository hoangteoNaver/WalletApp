//
//  AddCardViewModel.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine

struct AddCardViewModel {
    let navigator: AddCardNavigatorType
    let useCase: AddCardUseCaseType
    let delegate: PassthroughSubject<Void, Never>
}

// MARK: - ViewModel
extension AddCardViewModel: ViewModel {
    struct Input {
        let addTrigger: Driver<Card>
    }
    
    final class Output: ObservableObject {
        
    }
    
    func transform(_ input: Input, cancelBag: CancelBag) -> Output {
        let output = Output()
        
        input.addTrigger
            .map { card in
                self.useCase.addCard(card: card)
            }
            .map({ _ in
                self.delegate.send(())
            })
            .sink{ _ in
                navigator.popPreviousView(animated: true)
            }
            .store(in: cancelBag)
        return output
    }
}
