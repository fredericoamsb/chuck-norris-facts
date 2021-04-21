//
//  SearchFactsViewControllerTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 10/04/21.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
@testable import Facts

class SearchFactsViewControllerTests: XCTestCase {

    var scheduler: TestScheduler!
    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var sut: SearchFactsViewController!
    var vm: SearchFactsViewModel!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        vm = SearchFactsViewModel(coordinator: factsCoordinatorMock)
        sut = SearchFactsViewController(viewModel: vm)
    }

    override func tearDown() {
        scheduler = nil
        factsCoordinatorMock = nil
        vm = nil
        sut = nil
    }

    func test_searchBarPlaceholder() {
        XCTAssertEqual(sut.searchController.searchBar.placeholder, L10n.SearchFacts.SearchBar.placeholder)
    }

    func test_searchBarPlaceholder_shouldStartEmpty() {
        XCTAssertEqual(sut.searchController.searchBar.text, "")
    }

    func test_shouldNotHaveMemoryLeak() {
        weak var leakReference = sut

        sut = nil

        XCTAssert(leakReference == nil)
    }

    func test_rxShouldNotLeak() {
        let expectedTotal = Resources.total
        autoreleasepool {
            let vc = SearchFactsViewController(viewModel: vm)
            vc.loadViewIfNeeded()
        }
        let currentTotal = Resources.total
        XCTAssertEqual(expectedTotal, currentTotal)
    }
}
