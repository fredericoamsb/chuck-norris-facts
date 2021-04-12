//
//  Fact.swift
//  Domain
//
//  Created by Frederico Augusto on 03/04/21.
//

public struct Fact: Decodable {

    public let id: String
    public let url: String?
    public let categories: [String]
    public let value: String

    public init(id: String, url: String? = nil, categories: [String] = [], value: String) {
        self.id = id
        self.url = url
        self.categories = categories
        self.value = value
    }
}
