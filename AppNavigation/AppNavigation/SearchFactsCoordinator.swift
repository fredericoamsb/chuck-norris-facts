//
//  SearchFactsCoordinator.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import SearchChuckNorrisFacts

public class SearchFactsCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let searchFactsFactory: SearchFactsFactoryProtocol

    public init(navigationController: UINavigationController, searchFactsFactory: SearchFactsFactoryProtocol) {
        self.navigationController = navigationController
        self.searchFactsFactory = searchFactsFactory
    }

    public func start() {
        let searchFactsViewController = searchFactsFactory.makeSearchFactsViewController()
        navigationController.pushViewController(searchFactsViewController, animated: true)
    }
}
