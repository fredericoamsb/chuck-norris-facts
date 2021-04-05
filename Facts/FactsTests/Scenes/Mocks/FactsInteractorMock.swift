//
//  FactsInteractorMock.swift
//  FactsTests
//
//  Created by Frederico Augusto on 03/04/21.
//

import RxSwift
import Domain

final class FactsInteractorMock: FactsInteractorHandling {

    var delayTime = 5
    var searchFactsReturnValue: Observable<[Fact]> = .just([])
    var testRaceCondition = false
    public func searchFacts(query: String) -> Observable<[Fact]> {
        if testRaceCondition {
            let x = delayTime
            if delayTime == 0 {
                delayTime = 5
            } else {
                delayTime -= 1
            }

            return searchFactsReturnValue.delay(.milliseconds(x), scheduler: MainScheduler.instance)
        }

        return searchFactsReturnValue
    }
}
