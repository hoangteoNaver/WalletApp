//
//  Assembler.swift
//  WalletApp
//
//  Created by FVFH412VQ6L7 on 07/09/2023.
//

protocol Assembler: class,
    LoginAssembler,
    CardsAssembler,
    CardDetailAssembler,
    AddCardAssembler,
    GatewaysAssembler{
    
}

final class DefaultAssembler: Assembler {
    
}

final class PreviewAssembler: Assembler {
    
}
