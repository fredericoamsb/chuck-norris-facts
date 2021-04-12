//
//  RepositoryFactory.swift
//  DI
//
//  Created by Frederico Augusto on 11/04/21.
//

import Swinject
import Networking

class RepositoryFactory: BaseFactory, RepositoryFactoryProtocol {

    func makeFactsRepository() -> FactsRepository {
        let repository = resolver.resolveSafe(FactsRepository.self)
        return repository
    }
}
