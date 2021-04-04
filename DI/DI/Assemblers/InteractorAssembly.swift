//
//  InteractorAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 04/04/21.
//

import Swinject
import Domain

class InteractorAssembly: Assembly {

    func assemble(container: Container) {

        // MARK: FactsInteractor
        container.register(FactsInteractorHandling.self) { _ in
            let factsInteractor = FactsInteractor()
            return factsInteractor
        }
    }
}
