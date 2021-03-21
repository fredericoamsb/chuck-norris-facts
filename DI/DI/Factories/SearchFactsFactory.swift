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
        guard let viewModel = resolver.resolve(SearchFactsViewModelable.self) as? SearchFactsViewModel else {
            preconditionFailure("SearchFactsViewModelable is nil")
        }
        let viewController = SearchFactsViewController(viewModel: viewModel)
        return viewController
    }
}
