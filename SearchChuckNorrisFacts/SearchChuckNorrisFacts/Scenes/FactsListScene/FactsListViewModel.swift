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

    func showSearch()
}

public final class FactsListViewModel: FactsListViewModelable {

    public let coodinator: FactsListSceneCoordinating
    public var facts = BehaviorRelay(value: [FactViewModel(description: "Teste 1"),
                                             FactViewModel(description: "Teste 2")])

    public init(coordinator: FactsListSceneCoordinating) {

        self.coodinator = coordinator
    }

    public func showSearch() {
        coodinator.showSearch()
    }
}
