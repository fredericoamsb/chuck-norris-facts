//
//  FactsListViewControllerTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 07/04/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Facts
@testable import Domain

class FactListViewControllerTests: XCTestCase {

    var scheduler: TestScheduler!
    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var factsInteractorMock: FactsInteractorMock!
    var sut: FactsListViewController!
    var vm: FactsListViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        factsInteractorMock = FactsInteractorMock()
        vm = FactsListViewModel(coordinator: factsCoordinatorMock, interactor: factsInteractorMock)
        sut = FactsListViewController(viewModel: vm)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        factsCoordinatorMock = nil
        factsInteractorMock = nil
        vm = nil
        sut = nil
        disposeBag = nil
    }

    func test_title_shouldBeCorrect() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(L10n.FactsList.title, sut.title)
    }

    func test_searchButtonIcon_shouldBeCorrect() {
        sut.loadViewIfNeeded()

        XCTAssertTrue(sut.navigationItem.rightBarButtonItem!.description.contains("systemItem=Search"))
    }

    func test_whenTapSearchButton_shouldShowSearchScreen() {
        sut.loadViewIfNeeded()

        let searchButtonTappedObserver = scheduler.createObserver(Void.self)
        vm.searchAction
            .bind(to: searchButtonTappedObserver)
            .disposed(by: disposeBag)

        scheduler.start()

        _ = sut.searchButton.target?.perform(sut.searchButton.action, with: nil)

        let searchButtonTappedEvents: [Void] = searchButtonTappedObserver.events.compactMap { $0.value.element }
        XCTAssertEqual(searchButtonTappedEvents.count, 1)
        XCTAssertTrue(factsCoordinatorMock.calledSearchFact)
    }

    func test_shouldNotHaveMemoryLeak() {
        weak var leakReference = sut

        sut = nil

        XCTAssert(leakReference == nil)
    }

    func test_rxShouldNotLeak() {
        let expectedTotal = Resources.total
        autoreleasepool {
            let vc = FactsListViewController(viewModel: vm)
            vc.loadViewIfNeeded()
        }
        let currentTotal = Resources.total
        XCTAssertEqual(expectedTotal, currentTotal)
    }
}
