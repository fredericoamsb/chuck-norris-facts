//
//  InteractorFactory.swift
//  DI
//
//  Created by Frederico Augusto on 04/04/21.
//

import Swinject
import Domain

class InteractorFactory: BaseFactory, InteractorFactoryProtocol {

    func makeFactsInteractor() -> FactsInteractor {
        let interactor = resolver.resolveSafe(FactsInteractor.self)
        return interactor
    }
}
