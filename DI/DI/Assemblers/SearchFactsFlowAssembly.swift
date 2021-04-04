//
//  SearchFactsFlowAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts
import AppNavigation
import Domain

class SearchFactsFlowAssembly: Assembly {

    func assemble(container: Container) {
        let searchFactsCoordinator = container.resolveSafe(SearchFactsCoordinator.self)
        let factsInteractor = container.resolveSafe(FactsInteractorHandling.self)

        // MARK: FactsListScene
        container.register(FactsListSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.register(FactsListViewModelable.self, factory: {(_: Resolver) in
            return FactsListViewModel(coordinator: searchFactsCoordinator, interactor: factsInteractor)
        })

        // MARK: SearchFactsScene
        container.register(SearchFactsSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.register(SearchFactsViewModelable.self, factory: {(_: Resolver) in
            return SearchFactsViewModel(coordinator: searchFactsCoordinator)
        })
    }
}
