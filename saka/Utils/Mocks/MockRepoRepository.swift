//
//  MockRepoRepository.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation
import Combine

struct MockRepoRepository: RepoRepository {
    let members: MemberList
    let error: Error?

    init(members: MemberList, error: Error? = nil) {
        self.members = members
        self.error = error
    }

    func fetchRepos() -> AnyPublisher<MemberList, Error> {
        if let error = error {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }

        return Just(members)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
