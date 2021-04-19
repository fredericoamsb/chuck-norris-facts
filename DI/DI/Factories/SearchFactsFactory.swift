//
//  SearchFactsFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts

class SearchFactsFactory: BaseFactory, SearchFactsManufacturing {

    func makeSearchFactsViewController() -> SearchFactsViewController {
        SearchFactsViewController(viewModel: resolver.resolveSafe(SearchFactsViewModelable.self))
    }
}
