//
//  SearchFactsViewModel.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import RxSwift
import RxCocoa

public enum SearchFactsSceneResult {
    case cancel
    case search(String)
}

public protocol SearchFactsSceneCoordinating {

    func backToList()
}

public protocol SearchFactsViewModelable {

    var cancelAction: PublishRelay<Void> { get }
    var searchAction: PublishRelay<String> { get }
    var result: Observable<SearchFactsSceneResult> { get }
}

public final class SearchFactsViewModel: SearchFactsViewModelable {

    public var cancelAction = PublishRelay<Void>()
    public var searchAction = PublishRelay<String>()
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
