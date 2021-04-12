//
//  RepositoryFactoryAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 11/04/21.
//

import Swinject
import Networking

class RepositoryFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(RepositoryFactoryProtocol.self, initializer: RepositoryFactory.init)
    }
}
