//
//  FactsListViewModelTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 02/04/21.
//

import XCTest
import Facts
import RxSwift
import RxTest

class FactsListViewModelTests: XCTestCase {

    var scheduler: TestScheduler!
    var fakeCoordinator: FakeSearchFactsCoordinator!
    var sut: FactsListViewModel!
    var disposeBag: DisposeBag!
    var factsInteractorMock: FactsInteractorMock!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        fakeCoordinator = FakeSearchFactsCoordinator(scheduler: scheduler)
        sut = FactsListViewModel(coordinator: fakeCoordinator)
        disposeBag = DisposeBag()
        factsInteractorMock = FactsInteractorMock()
    }

    override func tearDown() {
        sut = nil
        fakeCoordinator = nil
        disposeBag = nil
        scheduler = nil
        factsInteractorMock = nil
    }

    func test_FactsList_ShouldStartEmpty() {
        sut.facts.bind { list in
            XCTAssertEqual(list.count, 0)
        }.disposed(by: disposeBag)
    }

    func test_whenSearchButtonTapped_ShouldReceiveResultsCorrectly() {
        let searchButtonTappedObserver = scheduler.createObserver(SearchFactsSceneResult.self)

        fakeCoordinator.showSearch().bind(to: sut.searchActionResult).disposed(by: disposeBag)

        sut.searchActionResult.bind(to: searchButtonTappedObserver).disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(searchButtonTappedObserver.events, [.next(0, .search("query")),
                                                           .next(1, .cancel),
                                                           .next(2, .search(""))])
    }

    func test_whenCancelResultReceived_ShouldNotChangeFactsList() {
        let state = [FactViewModel(description: "description a", category: nil),
                     FactViewModel(description: "description b", category: nil)]
        sut.facts =  BehaviorSubject(value: state)

        let cancelButtonTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.cancel)])
        cancelButtonTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        var newState = [FactViewModel]()
        self.sut.facts.bind { list in
                newState = list
            }.disposed(by: self.disposeBag)

        scheduler.start()

        XCTAssertEqual(newState, state)
    }

    func test_whenSearchResultReceived_ShouldChangeFactsList() {
        let state = [FactViewModel(description: "description a", category: nil),
                     FactViewModel(description: "description b", category: nil)]
        sut.facts =  BehaviorSubject(value: state)

        let searchButtonTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
        searchButtonTapped.bind(to: self.sut.searchActionResult).disposed(by: self.disposeBag)

        var newState = [FactViewModel]()
        self.sut.facts.bind { list in
                newState = list
            }.disposed(by: self.disposeBag)

        scheduler.start()

        XCTAssertNotEqual(newState, state)
    }

    func test_whenRequestSearchSuccessful_ShouldReturnEmpty() {
        factsInteractorMock.searchFacts(query: "query").subscribe(onNext: { list in
            let viewModels = list.map { FactViewModel(description: $0.value, category: $0.category) }
            self.sut.facts =  BehaviorSubject(value: viewModels)
        }).disposed(by: disposeBag)

        sut.facts.bind { list in
            XCTAssertEqual(list.count, 0)
        }.disposed(by: disposeBag)
    }
}

final class FakeSearchFactsCoordinator: FactsListSceneCoordinating {

    let scheduler: TestScheduler

    init(scheduler: TestScheduler) {
        self.scheduler = scheduler
    }

    func showSearch() -> Observable<SearchFactsSceneResult> {
        let fakeSearchButtonTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query")),
                                                             .next(1, SearchFactsSceneResult.cancel),
                                                             .next(2, SearchFactsSceneResult.search(""))])

        return fakeSearchButtonTapped.asObservable()
    }
}
