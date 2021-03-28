//
//  CoordinatorFactoryProtocol.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 21/03/21.
//

import SearchChuckNorrisFacts

public protocol CoordinatorFactoryProtocol {

    func makeSearchFactsCoordinator() -> SearchFactsCoordinator
}
