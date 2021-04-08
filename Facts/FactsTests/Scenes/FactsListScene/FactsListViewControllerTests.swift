//
//  FactsListViewControllerTests.swift
//  FactsTests
//
//  Created by Frederico Augusto on 07/04/21.
//

import XCTest
import RxSwift
import RxTest
@testable import Facts
@testable import Domain

class FactListViewControllerTests: XCTestCase {

    var factsCoordinatorMock: SearchFactsCoordinatorMock!
    var factsInteractorMock: FactsInteractorMock!
    var sut: FactsListViewController!
    var vm: FactsListViewModel!

    override func setUp() {
        factsCoordinatorMock = SearchFactsCoordinatorMock(scheduler: scheduler)
        factsInteractorMock = FactsInteractorMock()
        vm = FactsListViewModel(coordinator: factsCoordinatorMock, interactor: factsInteractorMock)
        sut = FactsListViewController(viewModel: vm)

        sut.loadView()
        sut.viewDidLoad()
    }

    override func tearDown() {
        factsCoordinatorMock = nil
        factsInteractorMock = nil
        vm = nil
        sut = nil
    }

    func test_Title() {
        XCTAssertEqual(L10n.FactsList.title, sut.title)
    }

    func test_SearchButtonIcon() {
        XCTAssertTrue(sut.navigationItem.rightBarButtonItem!.description.contains("systemItem=Search"))
    }

}
