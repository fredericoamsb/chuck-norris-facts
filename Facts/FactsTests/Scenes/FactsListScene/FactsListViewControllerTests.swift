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
        sut.loadView()
        sut.viewDidLoad()
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
        XCTAssertEqual(L10n.FactsList.title, sut.title)
    }

    func test_searchButtonIcon_shouldBeCorrect() {
        XCTAssertTrue(sut.navigationItem.rightBarButtonItem!.description.contains("systemItem=Search"))
    }

    func test_whenTapSearchButton_shouldShowSearchScreen() {
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
}
