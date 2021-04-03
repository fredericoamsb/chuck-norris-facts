//
//  FactsListViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit
import RxSwift
import RxCocoa

public protocol FactsListSceneCoordinating {

    func showSearch() -> Observable<SearchFactsSceneResult>
}

public protocol FactsListViewModelable {

    // outputs
    var facts: BehaviorSubject<[FactViewModel]> { get }
    // inputs
    var searchAction: PublishRelay<Void> { get }
    var searchActionResult: PublishRelay<SearchFactsSceneResult> { get }
}

public final class FactsListViewModel: FactsListViewModelable {

    // outputs
    public var facts = BehaviorSubject(value: [FactViewModel]())
    // inputs
    public var searchAction = PublishRelay<Void>()
    public var searchActionResult = PublishRelay<SearchFactsSceneResult>()

    let disposeBag = DisposeBag()

    public init(coordinator: FactsListSceneCoordinating) {

        searchAction.bind { [weak self] in
            guard let self = self else {
                return
            }
            coordinator.showSearch()
                .bind(to: self.searchActionResult)
                .disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

        searchActionResult
            .bind { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .search(let query):
                self.facts.onNext([FactViewModel(description: query, category: nil)])
            default:
                break
            }
        }.disposed(by: disposeBag)
    }
}
