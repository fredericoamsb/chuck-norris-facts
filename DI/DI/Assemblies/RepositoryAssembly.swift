//
//  RepositoryAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 11/04/21.
//

import Swinject
import Domain
import Networking

class RepositoryAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(Domain.FactsRepositoryProtocol.self, initializer: FactsRepository.init)
    }
}
