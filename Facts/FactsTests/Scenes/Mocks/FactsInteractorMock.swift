//
//  FactsInteractorMock.swift
//  FactsTests
//
//  Created by Frederico Augusto on 03/04/21.
//

import RxSwift
import Domain

final class FactsInteractorMock: FactsInteractorHandling {

    var searchFactsReturnValue: Observable<[Fact]> = .just([])
    func searchFacts(query: String) -> Observable<[Fact]> {
        return searchFactsReturnValue
    }
}
