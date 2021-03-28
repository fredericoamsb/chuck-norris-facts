//
//  SearchFactsViewModel.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

public protocol SearchFactsSceneCoordinating {

    func backToList()
}

public final class SearchFactsViewModel: SearchFactsViewModelable {

    public let coordinator: SearchFactsSceneCoordinating

    public init(coordinator: SearchFactsSceneCoordinating) {

        self.coordinator = coordinator
    }

    public func backToList() {
        coordinator.backToList()
    }

    public func searchFact(query: String) {
        backToList()
    }
}
