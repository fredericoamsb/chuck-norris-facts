//
//  CoordinatorFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import AppNavigation
import Facts

class CoordinatorFactory: BaseFactory, CoordinatorManufacturing {

    func makeSearchFactsCoordinator() -> SearchFactsCoordinator {
        resolver.resolveSafe(SearchFactsCoordinator.self)
    }
}
