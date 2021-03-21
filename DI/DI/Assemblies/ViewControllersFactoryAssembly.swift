//
//  ViewControllersFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts

class ViewControllersFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SearchFactsFactoryProtocol.self) { resolver in
            return SearchFactsFactory(resolver: resolver)
        }
    }
}
