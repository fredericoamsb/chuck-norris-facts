//
//  BaseFactory.swift
//  DI
//
//  Created by Frederico Augusto on 21/03/21.
//

import Swinject

class BaseFactory {

    let resolver: Resolver

    init(resolver: Resolver) {
        self.resolver = resolver
    }
}
