//
//  RepoRepository.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation
import Combine

protocol RepoRepository {
    func fetchRepos() -> AnyPublisher<MemberList, Error>
}

struct RepoDataRepository: RepoRepository {
    func fetchRepos() -> AnyPublisher<MemberList, Error> {
        APIClient().getRepos()
    }
}
