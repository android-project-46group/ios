//
//  APIClient.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation
import Combine

struct APIClient {
    func getRepos() -> AnyPublisher<MemberList, Error> {

        // TODO: Change to various url?
        let url = URL(string: "https://kokoichi0206.mydns.jp/api/v1/members?gn=nogizaka&key=e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855")!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.allHTTPHeaderFields = [
            "Accept": "application/vnd.github.v3+json"
        ]

        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .tryMap() { element -> Data in
                guard let httpResponse = element.response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                print(element.data)
                return element.data
            }
            .decode(type: MemberList.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
