//
//  ResolverExtension.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject

extension Resolver {

    func resolveSafe<Service>(_ serviceType: Service.Type) -> Service {
        guard let dependency = resolve(serviceType, name: nil) else {
            preconditionFailure("\(serviceType) is nil")
        }
        return dependency
    }
}
