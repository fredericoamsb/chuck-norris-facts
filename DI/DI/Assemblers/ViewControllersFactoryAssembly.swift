//
//  ViewControllersFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts

class ViewControllersFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(FactsListFactoryProtocol.self) { resolver in
            return FactsListFactory(resolver: resolver)
        }

        container.register(SearchFactsFactoryProtocol.self) { resolver in
            return SearchFactsFactory(resolver: resolver)
        }
    }
}
