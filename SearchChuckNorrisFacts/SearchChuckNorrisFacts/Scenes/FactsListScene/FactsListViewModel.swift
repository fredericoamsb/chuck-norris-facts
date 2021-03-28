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
    public var facts = BehaviorSubject(value: [FactViewModel]())

    public init(coordinator: FactsListSceneCoordinating) {

        self.coodinator = coordinator
        facts.onNext([FactViewModel(description: "Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1",
                                    category: "ANIMALS"),
                      FactViewModel(description: "Teste 2",
                                    category: nil),
                      FactViewModel(description: "Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1",
                                    category: "ANIMALS"),
                      FactViewModel(description: "Teste 1 Teste 1 Teste 1",
                                    category: "ANIMALS"),
                      FactViewModel(description: "Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1",
                                    category: "ANIMALS"),
                      FactViewModel(description: "Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1 Teste 1",
                                    category: "ANIMALS")])
    }

    public func showSearch() {
        coodinator.showSearch()
    }
}
