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
        container.register(FactsInteractorHandling.self) { _ in
            return FactsInteractor()
        }
    }
}
