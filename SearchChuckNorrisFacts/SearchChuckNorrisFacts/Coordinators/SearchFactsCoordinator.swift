//
//  SearchFactsCoordinator.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import RxSwift
import SearchChuckNorrisFacts

public class SearchFactsCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    private let factsListFactory: FactsListFactoryProtocol
    private let searchFactsFactory: SearchFactsFactoryProtocol

    public init(navigationController: UINavigationController,
                factsListFactory: FactsListFactoryProtocol,
                searchFactsFactory: SearchFactsFactoryProtocol) {

        self.navigationController = navigationController
        self.factsListFactory = factsListFactory
        self.searchFactsFactory = searchFactsFactory
    }

    public func start() {
        let factsListViewController = factsListFactory.makeFactsListViewController()
        navigationController.pushViewController(factsListViewController, animated: true)
    }
}

extension SearchFactsCoordinator: FactsListSceneCoordinating {

    public func showSearch(query: BehaviorSubject<String>) {
        let searchFactsViewController = searchFactsFactory.makeSearchFactsViewController()
        searchFactsViewController.viewModel.searchQuery = query

        let searchFactsNavigationController = UINavigationController(rootViewController: searchFactsViewController)
        navigationController.present(searchFactsNavigationController, animated: true)
    }
}

extension SearchFactsCoordinator: SearchFactsSceneCoordinating {

    public func backToList() {
        navigationController.dismiss(animated: true)
    }
}
