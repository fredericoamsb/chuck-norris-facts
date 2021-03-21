//
//  SearchFactsFlowAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject
import SearchChuckNorrisFacts

class SearchFactsFlowAssembly: Assembly {

    func assemble(container: Container) {
        container.register(SearchFactsViewModelable.self, factory: {(_: Resolver) in
            return SearchFactsViewModel()
        })
    }
}
