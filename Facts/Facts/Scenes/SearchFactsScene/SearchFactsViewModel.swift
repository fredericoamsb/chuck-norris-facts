//
//  SearchFactsViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 21/03/21.
//

import RxSwift
import RxCocoa

public protocol SearchFactsSceneCoordinating {

    func backToList()
}

public protocol SearchFactsViewModelable {

    // MARK: inputs
    var cancelAction: PublishRelay<Void> { get }
    var searchAction: PublishRelay<String> { get }
    // MARK: outputs
    var result: Observable<SearchFactsSceneResult> { get }
}

public final class SearchFactsViewModel: SearchFactsViewModelable {

    // MARK: inputs
    public var cancelAction = PublishRelay<Void>()
    public var searchAction = PublishRelay<String>()
    // MARK: outputs
    public var result: Observable<SearchFactsSceneResult>

    public init(coordinator: SearchFactsSceneCoordinating) {

        let cancelButtonTapped = cancelAction.asObservable().map { SearchFactsSceneResult.cancel }
        let searchButtonTapped = searchAction.asObservable().map { SearchFactsSceneResult.search($0) }

        result = Observable.merge(cancelButtonTapped, searchButtonTapped)
            .take(1)
            .do(onNext: { _ in
                coordinator.backToList()
            })
    }
}
