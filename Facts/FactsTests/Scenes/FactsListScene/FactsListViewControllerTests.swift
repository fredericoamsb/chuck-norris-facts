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

    func test_Title() {
        XCTAssertEqual(L10n.FactsList.title, sut.title)
    }

    func test_SearchButtonIcon() {
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
    }

    // func test_whenTapFactShareButton_shouldShowShareActivity() {
    //     factsInteractorMock.searchFactsReturnValue = .just([Fact(id: "111", value: "description a"),
    //                                                         Fact(id: "222", value: "description b")])
    //     let keyboardSearchKeyTapped = scheduler.createHotObservable([.next(0, SearchFactsSceneResult.search("query"))])
    //     keyboardSearchKeyTapped.bind(to: vm.searchActionResult).disposed(by: self.disposeBag)

    //     let shareFactObserver = scheduler.createObserver(FactViewModel.self)
    //     vm.factShareButtonAction
    //         .map { $0 }
    //         .bind(to: shareFactObserver)
    //         .disposed(by: disposeBag)

    //     scheduler.start()

    //     let indexPath = IndexPath(row: 0, section: 0)
    //     let factCell = sut.factsListTableView.cellForRow(at: indexPath) as! FactListCell
    //     factCell.shareButton.sendActions(for: .touchUpInside)

    //     let shareFactEvents: [FactViewModel] = shareFactObserver.events.compactMap { $0.value.element }
    //     XCTAssertEqual(shareFactEvents.count, 1)
    // }
}
