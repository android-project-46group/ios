//
//  File.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import Foundation
import Combine

class MemberListViewModel: ObservableObject {
    @Published private(set) var memberList: Stateful<MemberList> = .idle

    private var cancellables = Set<AnyCancellable>()

    private let repoRepository: RepoRepository
    
    let allGroups = ["乃木坂46", "櫻坂46", "日向坂46"]
    var selectedGroup = "乃木坂46"

    init(repoRepository: RepoRepository = RepoDataRepository()) {
        self.repoRepository = repoRepository
    }

    func onAppear() {
        loadMembers()
    }

    private func loadMembers() {
        repoRepository.fetchRepos()
            .handleEvents(receiveSubscription: { [weak self] _ in
                self?.memberList = .loading
            })
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    print("Error: \(error)")
                    self?.memberList = .failed(error)
                case .finished: print("Finished")
                }
            }, receiveValue: { [weak self] repos in
                print(repos)
                self?.memberList = .loaded(repos)
            }
            ).store(in: &cancellables)
    }
}
