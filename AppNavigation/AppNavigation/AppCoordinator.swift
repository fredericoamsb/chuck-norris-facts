//
//  AppCoordinator.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import Facts

public class AppCoordinator: Coordinator {

    public var navigationController: UINavigationController
    public var childCoordinators: [Coordinator] = []
    let coordinatorFactory: CoordinatorManufacturing

    public init(navigationController: UINavigationController, coordinatorFactory: CoordinatorManufacturing) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
    }

    public func start() {
        let searchFactsCoordinator = coordinatorFactory.makeSearchFactsCoordinator()
        searchFactsCoordinator.start()
        childCoordinators.append(searchFactsCoordinator)
    }
}
