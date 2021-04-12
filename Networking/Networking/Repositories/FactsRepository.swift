//
//  FactsRepository.swift
//  Networking
//
//  Created by Frederico Augusto on 10/04/21.
//

import Domain
import Moya
import RxSwift

public class FactsRepository: FactsRepositoryProtocol {

    public init() {}

    public func searchFacts(query: String) -> Single<SearchFactsResponse> {
        var provider = MoyaProvider<ChuckNorrisTarget>()

        // UITests
        #if DEBUG
        if LaunchArguments.contains(.uiTest) {
            provider = MoyaProvider<ChuckNorrisTarget>(stubClosure: MoyaProvider<ChuckNorrisTarget>.delayedStub(0))
        }
        if LaunchArguments.contains(.mockDelay) {
            provider = MoyaProvider<ChuckNorrisTarget>(stubClosure: MoyaProvider<ChuckNorrisTarget>.delayedStub(1))
        }
        #endif

        let request = provider.rx.request(.searchFacts(query))
            .map(SearchFactsResponse.self)
            .retry(3)

        let disposeBag = DisposeBag()
        request.subscribe().disposed(by: disposeBag)

        return request
    }
}
