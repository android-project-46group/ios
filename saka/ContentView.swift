//
//  ContentView.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/21.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel: MemberListViewModel
    
    init(viewModel: MemberListViewModel = MemberListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationView {
            switch viewModel.memberList {
            case .idle, .loading:
                ProgressView("loading...")
            case let .loaded(members):
                if members.members.isEmpty {
                    Text("something wrong about API.")
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        VStack {
                            ForEach(members.members) { member in
                                Text(member.user_name)
                            }
                        }
                    }
                    .padding()
                }
            case let .failed(error):
                
                Text(error.localizedDescription)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View{
        Group {
            ContentView(
                viewModel: MemberListViewModel(
                
                    repoRepository: MockRepoRepository(
                        members: MemberList(members: [
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                        ]),
                        error: nil
                    )
                )
            )
                .previewDisplayName("Default")
            
            ContentView(
                viewModel: MemberListViewModel(
                
                    repoRepository: MockRepoRepository(
                        members: MemberList(members: []),
                        error: nil
                    )
                )
            )
                .previewDisplayName("Empty List??")
            
            ContentView(
                viewModel: MemberListViewModel(
                
                    repoRepository: MockRepoRepository(
                        members: MemberList(members: []),
                        error: DummyError()
                    )
                )
            )
                        .previewDisplayName("Error")
        }
    }
}
