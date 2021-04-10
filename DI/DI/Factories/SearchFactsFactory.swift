//
//  SearchFactsFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts

class SearchFactsFactory: BaseFactory, SearchFactsFactoryProtocol {

    func makeSearchFactsViewController() -> SearchFactsViewController {
        let searchFactsViewController = resolver.resolveSafe(SearchFactsViewController.self)
        return searchFactsViewController
    }
}
