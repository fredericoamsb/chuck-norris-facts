//
//  CoordinatorFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import AppNavigation

class CoordinatorFactory: CoordinatorFactoryProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func makeSearchFactsCoordinator() -> SearchFactsCoordinator {
        let coordinator = resolver.resolveSafe(SearchFactsCoordinator.self)
        return coordinator
    }
}
