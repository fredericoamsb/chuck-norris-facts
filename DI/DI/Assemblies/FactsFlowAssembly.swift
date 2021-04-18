//
//  SearchFactsFlowAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts
import AppNavigation

class FactsFlowAssembly: Assembly {

    func assemble(container: Container) {
        let searchFactsCoordinator = container.resolveSafe(SearchFactsCoordinator.self)

        // MARK: FactsListScene
        container.register(FactsListSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.autoregister(FactsListViewModelable.self, initializer: FactsListViewModel.init)

        // MARK: SearchFactsScene
        container.register(SearchFactsSceneCoordinating.self) { _ in searchFactsCoordinator }
        container.autoregister(SearchFactsViewModelable.self, initializer: SearchFactsViewModel.init)
    }
}
