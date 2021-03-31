//
//  FactsListFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import Facts

class FactsListFactory: BaseFactory, FactsListFactoryProtocol {

    func makeFactsListViewController() -> FactsListViewController {
        let viewModel = resolver.resolveSafe(FactsListViewModelable.self)
        let viewController = FactsListViewController(viewModel: viewModel)
        return viewController
    }
}
