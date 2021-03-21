//
//  DepedencyInjector.swift
//  DI
//
//  Created by Frederico Augusto on 20/03/21.
//

import UIKit
import Swinject
import AppNavigation

public class DependencyInjector {

    private let navigationController: UINavigationController

    public init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    public func build(completion: (_ appCoordinator: AppCoordinator) -> ()) {
        let assembler = Assembler([
            CoordinatorFactoryAssembly(),
            CoordinatorAssembly(navigationController: self.navigationController),
            ViewControllersFactoryAssembly(),
            SearchFactsFlowAssembly()
        ])
        let appCoordinator = assembler.resolver.resolve(AppCoordinator.self)!
        completion(appCoordinator)
    }

}
