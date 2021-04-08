//
//  SearchFactsCoordinator.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import RxSwift

public protocol Coordinator {

    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get }
    func start()
}

public class SearchFactsCoordinator: Coordinator {

    public var childCoordinators: [Coordinator] = []
    public var navigationController: UINavigationController
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

    public func showSearch() -> Observable<SearchFactsSceneResult> {
        let searchFactsViewController = searchFactsFactory.makeSearchFactsViewController()
        let viewModel = searchFactsViewController.viewModel

        let searchFactsNavigationController = UINavigationController(rootViewController: searchFactsViewController)
        navigationController.present(searchFactsNavigationController, animated: true)

        return viewModel.result
    }
}

extension SearchFactsCoordinator: SearchFactsSceneCoordinating {

    public func backToList() {
        navigationController.dismiss(animated: true)
    }
}
