//
//  FactViewModel.swift
//  Facts
//
//  Created by Frederico Augusto on 25/03/21.
//

import Foundation

public final class FactViewModel {

    let description: String
    let category: String?

    public init(description: String, category: String?) {
        self.description = description
        self.category = category
    }
}
