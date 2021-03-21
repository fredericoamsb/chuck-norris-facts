//
//  CoordinatorAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import Swinject
import AppNavigation
import SearchChuckNorrisFacts

class CoordinatorAssembly: Assembly {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func assemble(container: Container) {

        let coordinatorFactory = container.resolveSafe(CoordinatorFactoryProtocol.self)

        //MARK: AppCoordinator
        container.register(AppCoordinator.self) { resolver in
            let appCoordinator = AppCoordinator(navigationController: self.navigationController, coordinatorFactory: coordinatorFactory)
            return appCoordinator
        }

        let appCoordinator = container.resolveSafe(AppCoordinator.self)

        //MARK: SearchFactsCoordinator
        container.register(SearchFactsCoordinator.self) { resolver in
            let searchFactsFactory = resolver.resolveSafe(SearchFactsFactoryProtocol.self)
            let searchFactsCoordinator = SearchFactsCoordinator(navigationController: appCoordinator.navigationController,
                                                                searchFactsFactory: searchFactsFactory)
            return searchFactsCoordinator
        }
    }
}
