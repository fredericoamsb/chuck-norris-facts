//
//  FactsCoordinatorMock.swift
//  FactsTests
//
//  Created by Frederico Augusto on 04/04/21.
//

import RxSwift
import RxTest
@testable import Facts

final class SearchFactsCoordinatorMock: FactsListSceneCoordinating {

    let scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    var showSearchReturnValue = [Recorded<Event<SearchFactsSceneResult>>]()
    func showSearch() -> Observable<SearchFactsSceneResult> {
        let fakeSearchButtonTapped = scheduler.createHotObservable(showSearchReturnValue)

        return fakeSearchButtonTapped.asObservable()
    }

    func shareFact(_ fact: FactViewModel) {}
}
