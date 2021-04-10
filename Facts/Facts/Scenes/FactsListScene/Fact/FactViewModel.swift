//
//  FactViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 25/03/21.
//

import Foundation
import Domain

public final class FactViewModel: Equatable {

    let description: String
    let category: String?
    let url: String?

    public init(description: String, category: String? = nil, url: String? = nil) {
        self.description = description
        self.category = category
        self.url = url
    }

    public static func == (lhs: FactViewModel, rhs: FactViewModel) -> Bool {
        lhs.description == rhs.description && lhs.category == rhs.category && lhs.url == rhs.url
    }
}

extension Fact {

    var asViewModel: FactViewModel {
        FactViewModel(description: self.value, category: self.category, url: self.url)
    }
}

extension Array where Element == Fact {

    var asViewModels: [FactViewModel] {
        self.map { $0.asViewModel }
    }
}
