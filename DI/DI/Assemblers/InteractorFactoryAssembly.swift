//
//  InteractorFactoryAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 04/04/21.
//

import Swinject
import Domain

class InteractorFactoryAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(InteractorFactoryProtocol.self, initializer: InteractorFactory.init)
    }
}
