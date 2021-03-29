//
//  SearchFactsFactoryProtocol.swift
//  SearchChuckNorrisFacts
//
//  Created by Frederico Augusto on 21/03/21.
//

public protocol SearchFactsFactoryProtocol {

    func makeSearchFactsViewController() -> (SearchFactsViewController, SearchFactsViewModelable)
}
