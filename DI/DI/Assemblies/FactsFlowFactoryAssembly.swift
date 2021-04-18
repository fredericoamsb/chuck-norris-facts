//
//  FactsFlowFactoryAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts
import AppNavigation

class FactsFlowFactoryAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: FactsListScene
        container.register(FactsListManufacturing.self) { resolver in
            FactsListFactory(resolver: resolver)
        }

        // MARK: SearchFactsScene
        container.register(SearchFactsManufacturing.self) { resolver in
            SearchFactsFactory(resolver: resolver)
        }
    }
}
