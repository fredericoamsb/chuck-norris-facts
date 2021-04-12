//
//  FactsInteractor.swift
//  Domain
//
//  Created by Frederico Augusto on 04/04/21.
//

import RxSwift

protocol FactsInteractionHolding {

    var repository: FactsRepositoryProtocol { get }
    init(repository: FactsRepositoryProtocol)
}

public protocol FactsInteractorHandling {

    func searchFacts(query: String) -> Single<SearchFactsResponse>
}

public final class FactsInteractor: FactsInteractionHolding {

    var repository: FactsRepositoryProtocol

    public init(repository: FactsRepositoryProtocol) {
        self.repository = repository
    }
}

extension FactsInteractor: FactsInteractorHandling {

    public func searchFacts(query: String) -> Single<SearchFactsResponse> {
        return repository.searchFacts(query: query)
    }
}
