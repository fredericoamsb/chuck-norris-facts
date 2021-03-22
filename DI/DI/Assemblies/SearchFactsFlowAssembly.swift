//
//  SearchFactsFlowAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts
import AppNavigation

class SearchFactsFlowAssembly: Assembly {

    func assemble(container: Container) {
        let searchFactsCoordinator = container.resolveSafe(SearchFactsCoordinator.self)

        // MARK: FactsListScene
        container.register(FactsListSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.register(FactsListViewModelable.self, factory: {(_: Resolver) in
            return FactsListViewModel(coordinator: searchFactsCoordinator)
        })

        // MARK: SearchFactsScene
        container.register(SearchFactsSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.register(SearchFactsViewModelable.self, factory: {(_: Resolver) in
            return SearchFactsViewModel(coordinator: searchFactsCoordinator)
        })
    }
}
