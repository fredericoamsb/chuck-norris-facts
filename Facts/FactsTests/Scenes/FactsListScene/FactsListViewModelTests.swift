//
//  FactsListViewModelTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 02/04/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Facts
@testable import Domain

class FactsListViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var factsInteractorMock: FactsInteractorMock!
    var sut: FactsListViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        factsInteractorMock = FactsInteractorMock()
        sut = FactsListViewModel(coordinator: factsCoordinatorMock, interactor: factsInteractorMock)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        factsCoordinatorMock = nil
        factsInteractorMock = nil
        sut = nil
        disposeBag = nil
    }

    func test_FactsList_ShouldStartEmpty() {
        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let facts = factsObserver.events.map { $0.value.element }.first
        XCTAssertEqual(facts, [])
    }

    func test_whenSearchButtonTapped_ShouldReceiveResultsCorrectly() {
        let searchButtonTappedObserver = scheduler.createObserver(SearchFactsSceneResult.self)

        factsCoordinatorMock.showSearchReturnValue = [.next(0, .search("query")),
                                                      .next(1, .cancel),
                                                      .next(2, .search(""))]
        factsCoordinatorMock.showSearch().bind(to: sut.searchActionResult).disposed(by: disposeBag)

        sut.searchActionResult.bind(to: searchButtonTappedObserver).disposed(by: disposeBag)

        scheduler.start()

        let resultEvents = searchButtonTappedObserver.events.map { $0.value.element }
        XCTAssertEqual(resultEvents, [.search("query"), .cancel, .search("")])
    }

    func test_whenCancelResultReceived_ShouldNotChangeFactsListState() {
        let state = [FactViewModel(description: "description a", category: nil),
                     FactViewModel(description: "description b", category: nil)]
        sut.facts.onNext(state)

        let cancelButtonTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.cancel)])
        cancelButtonTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let newState = factsObserver.events.compactMap { $0.value.element }.last
        XCTAssertEqual(newState, state)
    }

    func test_whenSearchResultReceived_ShouldChangeFactsList() {
        let state = [FactViewModel(description: "description a", category: nil),
                     FactViewModel(description: "description b", category: nil)]
        sut.facts.onNext(state)

        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let newState = factsObserver.events.compactMap { $0.value.element }.last
        XCTAssertNotEqual(newState, state)
    }

    func test_whenRequestSearchReturnSuccess_ShouldReturnCorrectFacts() {
        factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "111", url: nil, category: nil, value: "description a"),
                                                            Fact(id: "222", url: nil, category: nil, value: "description b")])

        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let factsEvents = factsObserver.events.map { $0.value.element }
        XCTAssertEqual(factsEvents[2], [Fact(id: "111", url: nil, category: nil, value: "description a"),
                                        Fact(id: "222", url: nil, category: nil, value: "description b")].asViewModels)
    }

    func test_whenRequestSearchReturnError_factsListShouldBeEmpty() {
        factsInteractorMock.searchFactsReturnValue = .error(NSError())

        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let facts = factsObserver.events.compactMap { $0.value.element }.last
        XCTAssertEqual(facts?.count, 0)
    }

    func test_whenRequestSearchReturnError_showAlertError() {
        factsInteractorMock.searchFactsReturnValue = .error(NSError())

        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let errorActionObserver = scheduler.createObserver(String.self)
        sut.errorAction.bind(to: errorActionObserver).disposed(by: disposeBag)

        scheduler.start()

        let errorEvents = errorActionObserver.events.compactMap { $0.value.element }
        XCTAssertFalse(errorEvents.isEmpty)
    }

    func test_whenRequestSearch_factsListShouldBeEmpty() {
        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        scheduler.start()

        let facts = factsObserver.events.compactMap { $0.value.element }[1]
        XCTAssertEqual(facts.count, 0)
    }

    func test_whenRequestSearch_shouldShowAndHideLoadingIndicator() {
        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let isLoadingObserver = scheduler.createObserver(Bool.self)
        sut.isLoading.bind(to: isLoadingObserver).disposed(by: disposeBag)

        self.factsInteractorMock.delayTime = 2
        scheduler.start()

        let whenRequest = isLoadingObserver.events.compactMap { $0.value.element }.first!
        XCTAssertTrue(whenRequest)

        _ = factsInteractorMock.searchFacts(query: "query").toBlocking().materialize()

        let afterRequest = isLoadingObserver.events.compactMap { $0.value.element }.last!
        XCTAssertFalse(afterRequest)
    }

    func test_whenRequestSearchRaceCondition_shouldOnlyReturnFromLastRequestMade() {
        let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(1, SearchFactsSceneResult.search("query 1")),
                                                                     .next(2, SearchFactsSceneResult.search("query 2")),
                                                                     .next(3, SearchFactsSceneResult.search("query 3"))])
        keyboardSearchKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        self.factsInteractorMock.testRaceCondition = true
        self.factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "1", url: nil, category: nil, value: "1")])
        scheduler.scheduleAt(1) {
            self.factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "2", url: nil, category: nil, value: "2")])
        }
        scheduler.scheduleAt(2) {
            self.factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "3", url: nil, category: nil, value: "3")])
        }

        scheduler.start()

        _ = factsInteractorMock.searchFacts(query: "query").toBlocking().materialize()

        let factsEvents = factsObserver.events.compactMap { $0.value.element }

        XCTAssertEqual(factsEvents.count, 5)
        XCTAssertEqual(factsEvents.last, [Fact(id: "3", url: nil, category: nil, value: "3")].asViewModels)
    }

    func test_whenRequestSearchRaceConditionThanPressCancel_shouldReturnLastRequestMade() {
        let keyboardSearchOrCancelKeyTapped = scheduler.createHotObservable([.next(1, SearchFactsSceneResult.search("query 1")),
                                                                     .next(2, SearchFactsSceneResult.search("query 2")),
                                                                     .next(3, SearchFactsSceneResult.cancel)])
        keyboardSearchOrCancelKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        let factsObserver = scheduler.createObserver([FactViewModel].self)
        sut.facts.bind(to: factsObserver).disposed(by: disposeBag)

        self.factsInteractorMock.testRaceCondition = true
        self.factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "1", url: nil, category: nil, value: "1")])
        scheduler.scheduleAt(1) {
            self.factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "2", url: nil, category: nil, value: "2")])
        }

        scheduler.start()

        keyboardSearchOrCancelKeyTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        _ = factsInteractorMock.searchFacts(query: "query").toBlocking().materialize()

        let factsEvents = factsObserver.events.compactMap { $0.value.element }

        XCTAssertEqual(factsEvents.count, 4)
        XCTAssertEqual(factsEvents.last, [Fact(id: "2", url: nil, category: nil, value: "2")].asViewModels)
    }
}
