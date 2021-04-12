//
//  ChuckNorrisTarget.swift
//  Networking
//
//  Created by Frederico Augusto on 10/04/21.
//

import Moya
import Domain

enum ChuckNorrisTarget {

    case searchFacts(String)
}

extension ChuckNorrisTarget: TargetType {

    var baseURL: URL { return URL(string: "https://api.chucknorris.io")! }

    var api: String { return "jokes" }

    var path: String {
        switch self {
        case .searchFacts:
            return "\(api)/search"
        }
    }

    var method: Moya.Method {
        switch self {
        case .searchFacts:
            return .get
        }
    }

    var task: Task {
        switch self {
        case .searchFacts(let query):
            return .requestParameters(parameters: ["query": query], encoding: URLEncoding.default)
        }
    }

    var sampleData: Data {
        switch self {
        case .searchFacts:
            var filename = "searchFactsResponse1"
            if LaunchArguments.contains(.mockError) {
                filename = "searchFactsResponseError"
            }
            guard let url = Bundle.main.url(forResource: filename, withExtension: "json"),
                  let data = try? Data(contentsOf: url) else {
                return Data()
            }
            return data
        }
    }

    var headers: [String: String]? {
        return ["Content-type": "application/json"]
    }
}
