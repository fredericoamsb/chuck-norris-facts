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
                    .asObservable()
                    .takeUntil(self.searchActionResult
                                .filter { $0.case == .search }.asObservable())
                    .subscribe { response in
                        self.isLoading.onNext(false)
                        if let facts = response.result {
                            self.facts.onNext(facts.asViewModels)
                        } else {
                            self.errorAction.onNext(response.message ?? L10n.FactsList.Alert.message)
                        }
                    } onError: { error in
                        self.isLoading.onNext(false)
                        self.errorAction.onNext(error.localizedDescription)
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
