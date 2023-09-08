//
//  CardGateway.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol CardGatewayType {
    func getCards() -> Observable<[Card]>
    func addCard(card: Card) -> Observable<Void>
}

struct CardGateway: CardGatewayType {
    private let store = Firestore.firestore().collection("card")
    func getCards() -> Observable<[Card]> {
        Future<[Card], Error> { promise in
            store.addSnapshotListener { querySnapshot, error in
                if let error = error {
                    promise(.failure(error))
                }
                
                let card = querySnapshot?.documents.compactMap({ document in
                    try? document.data(as: Card.self)
                })
                promise(.success(card!))
                
            }
        }
        .eraseToAnyPublisher()
    }
    
    func addCard(card: Card) -> Observable<Void> {
        Future<Void, Error> {
            promise in
            do {
                try store.addDocument(from: card)
                promise(.success(()))
            } catch {
                promise(.failure(error))
            }
        }
        .eraseToAnyPublisher()
    }
}

struct PreviewCardGateway: CardGatewayType {
    func getCards() -> Observable<[Card]> {
        Future<[Card], Error> { promise in
            
            promise(.success(cards))
        }
        .eraseToAnyPublisher()
    }
    
    func addCard(card: Card) -> Observable<Void> {
        Future<Void, Error> { promise in
            
            promise(.success(()))
        }
        .eraseToAnyPublisher()
    }
}
