//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import Swinject
import AppNavigation
import Facts

class CoordinatorAssembly: Assembly {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func assemble(container: Container) {

        let coordinatorFactory = container.resolveSafe(CoordinatorManufacturing.self)

        // MARK: AppCoordinator
        container.register(AppCoordinator.self) { _ in
            let appCoordinator = AppCoordinator(navigationController: self.navigationController, coordinatorFactory: coordinatorFactory)
            return appCoordinator
        }

        let appCoordinator = container.resolveSafe(AppCoordinator.self)

        // MARK: SearchFactsCoordinator
        container.register(SearchFactsCoordinator.self) { resolver in
            let factsListFactory = resolver.resolveSafe(FactsListManufacturing.self)
            let searchFactsFactory = resolver.resolveSafe(SearchFactsManufacturing.self)
            let searchFactsCoordinator = SearchFactsCoordinator(navigationController: appCoordinator.navigationController,
                                                                factsListFactory: factsListFactory,
                                                                searchFactsFactory: searchFactsFactory)
            return searchFactsCoordinator
        }
    }
}
