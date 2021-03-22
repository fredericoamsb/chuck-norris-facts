//
//  FactsListViewModel.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

import UIKit

public protocol FactsListSceneCoordinating {

    func showSearch()
}

public final class FactsListViewModel: FactsListViewModelable {

    public let coodinator: FactsListSceneCoordinating

    public init(coordinator: FactsListSceneCoordinating) {

        self.coodinator = coordinator
    }

    public func showSearch() {
        coodinator.showSearch()
    }
}
