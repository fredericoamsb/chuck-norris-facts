//
//  FactsListFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts

class FactsListFactory: BaseFactory, FactsListManufacturing {

    func makeFactsListViewController() -> FactsListViewController {
        FactsListViewController(viewModel: resolver.resolveSafe(FactsListViewModelable.self))
    }
}
