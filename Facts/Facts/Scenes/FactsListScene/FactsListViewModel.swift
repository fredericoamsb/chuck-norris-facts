//
//  FactsListViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa
import Domain

public protocol FactsListSceneCoordinating {

    func showSearch() -> Observable<SearchFactsSceneResult>
    func shareFact(_ fact: FactViewModel)
}

public protocol FactsListViewModelable {

    // MARK: outputs
    var facts: BehaviorSubject<[FactViewModel]> { get }
    var isLoading: PublishSubject<Bool> { get }
    var errorAction: PublishSubject<String> { get }
    // MARK: inputs
    var searchAction: PublishRelay<Void> { get }
    var searchActionResult: PublishRelay<SearchFactsSceneResult> { get }
    var factShareButtonAction: PublishRelay<FactViewModel> { get }
}

public final class FactsListViewModel: FactsListViewModelable {

    // MARK: outputs
    public var facts = BehaviorSubject(value: [FactViewModel]())
    public var isLoading = PublishSubject<Bool>()
    public var errorAction = PublishSubject<String>()
    // MARK: inputs
    public var searchAction = PublishRelay<Void>()
    public var searchActionResult = PublishRelay<SearchFactsSceneResult>()
    public var factShareButtonAction = PublishRelay<FactViewModel>()

    let disposeBag = DisposeBag()

    public init(coordinator: FactsListSceneCoordinating, interactor: FactsInteractorHandling) {

        searchAction.bind { [weak self] in
            guard let self = self else {
                return
            }
            coordinator.showSearch()
                .bind(to: self.searchActionResult)
                .disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

        searchActionResult.bind { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .search(let query):
                self.facts.onNext([])
                self.isLoading.onNext(true)
                interactor.searchFacts(query: query)
                    .retry(3)
                    .takeUntil(self.searchActionResult
                                .filter { $0.case == .search }.asObservable())
                    .subscribe { facts in
                        self.facts.onNext(facts.asViewModels)
                        self.isLoading.onNext(false)
                    } onError: { _ in
                        self.errorAction.onNext(L10n.FactsList.Alert.message)
                        self.isLoading.onNext(false)
                    }
                    .disposed(by: self.disposeBag)
            case .cancel:
                break
            }
        }.disposed(by: disposeBag)

        factShareButtonAction.bind { fact in
            coordinator.shareFact(fact)
        }.disposed(by: disposeBag)
    }
}
