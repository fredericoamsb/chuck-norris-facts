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

    var delayTime = 6
    var searchFactsReturnValue: Observable<[Fact]> = .just([])
    public func searchFacts(query: String) -> Observable<[Fact]> {
        let x = delayTime
        if delayTime == 0 {
            delayTime = 6
        } else {
            delayTime -= 3
        }
        searchFactsReturnValue = .just([Fact(id: "", url: nil, category: query, value: query),
                                        Fact(id: "", url: nil, category: query, value: query)])
        return searchFactsReturnValue.delay(.seconds(x), scheduler: MainScheduler.instance)
    }
}
