//
//  CoordinatorFactoryProtocol.swift
//  AppNavigation
//
//  Created by Frederico Augusto on 21/03/21.
//

import Facts

public protocol CoordinatorFactoryProtocol {

    func makeSearchFactsCoordinator() -> SearchFactsCoordinator
}
