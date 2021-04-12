//
//  XCTestCase.swift
//  FactsTests
//
//  Created by Frederico Augusto on 12/04/21.
//

import XCTest

extension XCTestCase {

    func getStub<T: Decodable>(filename: String, type: T.Type) throws -> T {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: filename, withExtension: "json") else {
            fatalError("File \(filename).json not found")
        }
        let data = try Data(contentsOf: url)
        let stub = try JSONDecoder().decode(T.self, from: data)
        return stub
    }
}
