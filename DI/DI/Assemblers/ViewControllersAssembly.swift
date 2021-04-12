//
//  ViewControllersAssembly.swift
//  DI
//
//  Created by Frederico Augusto on 07/04/21.
//

import Swinject
import Facts

class ViewControllersAssembly: Assembly {

    func assemble(container: Container) {
        container.autoregister(FactsListViewController.self, initializer: FactsListViewController.init)
        container.autoregister(SearchFactsViewController.self, initializer: SearchFactsViewController.init)
    }
}
