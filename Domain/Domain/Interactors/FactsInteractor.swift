//
//  FactsInteractor.swift
//  Domain
//
//  Created by Frederico Augusto on 04/04/21.
//

import RxSwift

public protocol FactsInteractorHandling {

    func searchFacts(query: String) -> Observable<[Fact]>
}

public final class FactsInteractor: FactsInteractorHandling {

    public init() {}

    public func searchFacts(query: String) -> Observable<[Fact]> {
        return .just([])
    }
}
