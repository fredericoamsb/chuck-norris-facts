//
//  CoordinatorFactoryAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import AppNavigation

class CoordinatorFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.register(CoordinatorManufacturing.self) { resolver in
            CoordinatorFactory(resolver: resolver)
        }
    }
}
