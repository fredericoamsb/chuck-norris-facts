//
//  SearchFactsSceneResult.swift
//  Facts
//
//  Created by Frederico Augusto on 18/04/21.
//

public enum SearchFactsSceneResult: Equatable {
    case cancel
    case search(String)

    var `case`: Case {
        switch self {
        case .search:
            return .search
        case .cancel:
            return .cancel
        }
    }

    enum Case {
        case cancel
        case search
    }
}
