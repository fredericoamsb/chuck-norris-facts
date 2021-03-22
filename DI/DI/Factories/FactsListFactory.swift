//
//  FactsListFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts

class FactsListFactory: FactsListFactoryProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func makeFactsListViewController() -> FactsListViewController {
        let viewModel = resolver.resolveSafe(FactsListViewModelable.self)
        let viewController = FactsListViewController(viewModel: viewModel)
        return viewController
    }
}
