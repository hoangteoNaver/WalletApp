//
//  GatewaysAssembler.swift
//  CleanArchitecture
//
//  Created by Tuan Truong on 7/14/20.
//  Copyright © 2020 Tuan Truong. All rights reserved.
//

protocol GatewaysAssembler {
    func resolve() -> CardGatewayType
    func resolve() -> AuthGatewayType
    //func resolve() -> RepoGatewayType
}

extension GatewaysAssembler where Self: DefaultAssembler {
    func resolve() -> CardGatewayType {
        CardGateway()
    }

    func resolve() -> AuthGatewayType {
        AuthGateway()
    }

//    func resolve() -> RepoGatewayType {
//        RepoGateway()
//    }
}

extension GatewaysAssembler where Self: PreviewAssembler {
    func resolve() -> CardGatewayType {
        PreviewCardGateway()
    }
    
    func resolve() -> AuthGatewayType {
        AuthGateway()
    }
    
//    func resolve() -> RepoGatewayType {
//        RepoGateway()
//    }
}
