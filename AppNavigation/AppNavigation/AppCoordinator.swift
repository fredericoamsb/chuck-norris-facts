//
//  AppCoordinator.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import Swinject
import SearchChuckNorrisFacts

protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    func start()
}

public class AppCoordinator: Coordinator {

    public var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    let coordinatorFactory: CoordinatorFactoryProtocol

    public init(navigationController: UINavigationController, coordinatorFactory: CoordinatorFactoryProtocol) {
        self.navigationController = navigationController
        self.coordinatorFactory = coordinatorFactory
    }

    public func start() {
        let searchFactsCoordinator = coordinatorFactory.makeSearchFactsCoordinator()
        searchFactsCoordinator.start()
        childCoordinators.append(searchFactsCoordinator)
    }
}
