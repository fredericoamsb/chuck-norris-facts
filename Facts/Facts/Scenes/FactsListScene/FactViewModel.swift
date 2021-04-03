//
//  FactViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 25/03/21.
//

import Foundation

public final class FactViewModel: Equatable {

    let description: String
    let category: String?

    public init(description: String, category: String?) {
        self.description = description
        self.category = category
    }

    public static func == (lhs: FactViewModel, rhs: FactViewModel) -> Bool {
        lhs.description == rhs.description && lhs.category == rhs.category
    }
}
