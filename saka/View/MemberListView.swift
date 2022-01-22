//
//  MemberListView.swift
//  saka
//
//  Created by Takahiro Tominaga on 2022/01/22.
//

import SwiftUI

struct MemberListView: View {
    @StateObject private var viewModel: MemberListViewModel

    init(viewModel: MemberListViewModel = MemberListViewModel()) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            
            TopBar()
        
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

    func TopBar() -> some View {
        HStack(spacing: 5) {
            ForEach(viewModel.allGroups, id: \.self) { group in
                GroupTitle(group: group)
            }
        }
        .font(.title2)
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.horizontal, 8)
    }
    
    func GroupTitle(group: String) -> some View {
        VStack(spacing: 2) {
            Text(group)
                .foregroundColor(group == viewModel.selectedGroup ? Color.purple : Color.gray)
                .padding(5)
            
            DoubleDivider(show: group == viewModel.selectedGroup)
        }
    }
    
    func DoubleDivider(show: Bool = true) -> some View {
        VStack(spacing: 2) {
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
            Rectangle()
                .padding(0)
                .foregroundColor(Color.purple)
                .opacity((show ? 1 : 0))
                .frame(height: 2)
        }
    }
}

struct MemberListView_Previews: PreviewProvider {
    static var previews: some View{
        Group {
            MemberListView(
                viewModel: MemberListViewModel(
                
                    repoRepository: MockRepoRepository(
                        members: MemberList(members: [
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
                            .mock1, .mock2, .mock3, .mock4, .mock5,
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
            
            MemberListView(
                viewModel: MemberListViewModel(
                
                    repoRepository: MockRepoRepository(
                        members: MemberList(members: []),
                        error: nil
                    )
                )
            )
            .previewDisplayName("Empty List??")
            
            MemberListView(
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
