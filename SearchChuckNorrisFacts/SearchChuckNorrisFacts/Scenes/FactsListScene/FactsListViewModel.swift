//
//  FactsListViewModel.swift
//  SearchChuckNorrisFacts
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

    var facts: BehaviorSubject<[FactViewModel]> { get }
    var searchAction: PublishRelay<Void> { get }
}

public final class FactsListViewModel: FactsListViewModelable {

    public var facts = BehaviorSubject(value: [FactViewModel]())
    public var searchAction = PublishRelay<Void>()

    let disposeBag = DisposeBag()

    public init(coordinator: FactsListSceneCoordinating) {

        searchAction.bind { [weak self] in
            guard let self = self else {
                return
            }
            coordinator.showSearch()
                .bind { self.getFacts(result: $0) }
                .disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
    }

    private func getFacts(result: SearchFactsSceneResult) {
        switch result {
        case .search(let query):
            facts.onNext([FactViewModel(description: query, category: nil)])
        default:
            break
        }
    }
}
