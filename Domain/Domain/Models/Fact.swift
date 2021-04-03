//
//  Fact.swift
//  Domain
//
//  Created by Frederico Augusto on 03/04/21.
//

public struct Fact: Decodable {

    public let id: String
    public let url: String?
    public let category: String?
    public let value: String

    init(id: String, url: String?, category: String?, value: String) {
        self.id = id
        self.url = url
        self.category = category
        self.value = value
    }
}
