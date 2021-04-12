//
//  FactsRepositoryProtocol.swift
//  Domain
//
//  Created by Frederico Augusto on 10/04/21.
//

import RxSwift

public protocol FactsRepositoryProtocol {

    func searchFacts(query: String) -> Single<SearchFactsResponse>
}
