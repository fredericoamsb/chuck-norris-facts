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
}

public protocol FactsListViewModelable {

    // outputs
    var facts: BehaviorSubject<[FactViewModel]> { get }
    var isLoading: BehaviorSubject<Bool> { get }
    // inputs
    var searchAction: PublishRelay<Void> { get }
    var searchActionResult: PublishRelay<SearchFactsSceneResult> { get }
}

public final class FactsListViewModel: FactsListViewModelable {

    // outputs
    public var facts = BehaviorSubject(value: [FactViewModel]())
    public var isLoading: BehaviorSubject<Bool> = BehaviorSubject(value: false)
    // inputs
    public var searchAction = PublishRelay<Void>()
    public var searchActionResult = PublishRelay<SearchFactsSceneResult>()

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
                self.isLoading.onNext(true)
                interactor.searchFacts(query: query)
                    .subscribe { facts in
                        self.facts.onNext(facts.asViewModels)
                    } onError: { error in
                        self.facts.onError(error)
                    } onCompleted: {
                        self.isLoading.onNext(false)
                    }.disposed(by: self.disposeBag)
            case .cancel:
                break
            }
        }.disposed(by: disposeBag)
    }
}
