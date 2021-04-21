//
//  SearchFactsViewModelTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Facts
@testable import Domain

class SearchFactsViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var sut: SearchFactsViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        sut = SearchFactsViewModel(coordinator: factsCoordinatorMock)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        factsCoordinatorMock = nil
        sut = nil
        disposeBag = nil
    }

    func test_whenkeyboardSearchKeyTapped_shoudResultCorrectly_and_backToFactsList() {
        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, "")])
        keyboardSearchKeyTapped.bind(to: sut.searchAction).disposed(by: disposeBag)

        let resultObserver = scheduler.createObserver(SearchFactsSceneResult.self)
        sut.result.bind(to: resultObserver).disposed(by: disposeBag)

        scheduler.start()

        let resultEvents = resultObserver.events.compactMap { $0.value.element }
        XCTAssertEqual(resultEvents, [.search("")])
        XCTAssertTrue(factsCoordinatorMock.calledBackToList)
    }

    func test_whenkCancelButtonTapped_shoudResultCorrectly_and_backToFactsList() {
        let cancelButtonTapped = scheduler.createHotObservable([.next(0, ())])
        cancelButtonTapped.bind(to: sut.cancelAction).disposed(by: disposeBag)

        let resultObserver = scheduler.createObserver(SearchFactsSceneResult.self)
        sut.result.bind(to: resultObserver).disposed(by: disposeBag)

        scheduler.start()

        let resultEvents = resultObserver.events.compactMap { $0.value.element }
        XCTAssertEqual(resultEvents, [.cancel])
        XCTAssertTrue(factsCoordinatorMock.calledBackToList)
    }

    func test_shouldNotHaveMemoryLeak() {
        weak var leakReference = sut

        sut = nil

        XCTAssert(leakReference == nil)
    }

    func test_rxShouldNotLeak() {
        let expectedTotal = Resources.total
        autoreleasepool {
            _ = SearchFactsViewModel(coordinator: factsCoordinatorMock)
        }
        let currentTotal = Resources.total
        XCTAssertEqual(expectedTotal, currentTotal)
    }
}
