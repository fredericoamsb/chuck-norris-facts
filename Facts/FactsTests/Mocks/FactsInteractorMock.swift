//
//  FactsInteractorMock.swift
//  FactsTests
//
//  Created by Frederico Augusto on 03/04/21.
//

import Foundation
import XCTest
import RxSwift
import Domain

enum ReturnType {
    case response1
    case response2
    case response3
    case error
}

final class FactsInteractorMock: XCTestCase, FactsInteractorHandling {

    var delayTime = 5
    var withRaceCondition = false

    var returnType: ReturnType = .response1

    var response1: SearchFactsResponse!
    var response2: SearchFactsResponse!
    var response3: SearchFactsResponse!
    var error: SearchFactsResponse!

    func searchFacts(query: String) -> Single<SearchFactsResponse> {
        do {
            response1 = try getStub(filename: "searchFactsResponse1", type: SearchFactsResponse.self)
            response2 = try getStub(filename: "searchFactsResponse2", type: SearchFactsResponse.self)
            response3 = try getStub(filename: "searchFactsResponse3", type: SearchFactsResponse.self)
            error = try getStub(filename: "searchFactsResponseError", type: SearchFactsResponse.self)
        } catch {
            fatalError()
        }

        let returnValue: Single<SearchFactsResponse>
        switch returnType {
        case .response1:
            returnValue = .just(response1)
        case .response2:
            returnValue = .just(response2)
        case .response3:
            returnValue = .just(response3)
        case .error:
            returnValue = .just(error)
        }

        if withRaceCondition {
            let x = delayTime
            delayTime -= 1
            if delayTime == 0 {
                delayTime = 5
            }

            return returnValue.delay(.milliseconds(x), scheduler: MainScheduler.instance)
        }

        return returnValue
    }
}
