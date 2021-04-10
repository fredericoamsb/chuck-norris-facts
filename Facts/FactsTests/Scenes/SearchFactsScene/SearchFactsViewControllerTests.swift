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
@testable import Domain

class SearchFactsViewControllerTests: XCTestCase {

    var scheduler: TestScheduler!
    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var sut: SearchFactsViewController!
    var vm: SearchFactsViewModel!
    var disposeBag: DisposeBag!

    override func setUp() {
        scheduler = TestScheduler(initialClock: 0)
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        vm = SearchFactsViewModel(coordinator: factsCoordinatorMock)
        sut = SearchFactsViewController(viewModel: vm)
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        scheduler = nil
        factsCoordinatorMock = nil
        vm = nil
        sut = nil
        disposeBag = nil
    }

    func test_searchBarPlaceholder() {
        XCTAssertEqual(sut.searchController.searchBar.placeholder, L10n.SearchFacts.SearchBar.placeholder)
    }

    func test_searchBarPlaceholder_shouldStartEmpty() {
        XCTAssertEqual(sut.searchController.searchBar.text, "")
    }

    func test_searchBarPlaceholder_shouldStartFocused() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(50)) {
            XCTAssertEqual(self.sut.searchController.searchBar.isFirstResponder, true)
        }
    }
}
