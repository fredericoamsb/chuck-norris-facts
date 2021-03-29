//
//  SearchFactsFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts

class SearchFactsFactory: BaseFactory, SearchFactsFactoryProtocol {

    func makeSearchFactsViewController() -> (SearchFactsViewController, SearchFactsViewModelable) {
        let viewModel = resolver.resolveSafe(SearchFactsViewModelable.self)
        let viewController = SearchFactsViewController(viewModel: viewModel)
        return (viewController, viewModel)
    }
}
