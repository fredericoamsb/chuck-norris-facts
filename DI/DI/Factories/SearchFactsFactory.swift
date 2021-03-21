//
//  SearchFactsFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts

class SearchFactsFactory: SearchFactsFactoryProtocol {

    private let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }

    func makeSearchFactsViewController() -> SearchFactsViewController {
        let viewModel = resolver.resolveSafe(SearchFactsViewModelable.self)
        let viewController = SearchFactsViewController(viewModel: viewModel)
        return viewController
    }
}
