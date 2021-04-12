//
//  SearchFactsResponse.swift
//  Domain
//
//  Created by Frederico Augusto on 10/04/21.
//

public struct SearchFactsResponse: Decodable {

    // success response
    public let total: Int?
    public let result: [Fact]?

    // error response
    public let status: Int?
    public let error: String?
    public let message: String?
}
