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
        let success: Observable<[Fact]> = .just([Fact(id: "", category: query, value: query),
                                                 Fact(id: "", category: query, value: query)])
        let error: Observable<[Fact]> = .error(NSError())

        if LaunchArguments.contains(.mockDelay) {
            return success.delay(.milliseconds(500), scheduler: MainScheduler.instance)
        }
        if LaunchArguments.contains(.mockError) {
            return error
        }
        return success
    }
}
