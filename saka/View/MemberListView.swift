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
                Group {
                    switch viewModel.memberList {
                    case .idle, .loading:
                        ProgressView("loading...")
                    case let .loaded(members):
                        if members.members.isEmpty {
                            Text("something wrong about API.")
                        } else {
                            
                            // MARK: Main List about members
                            MainList(members: members.members)
                        }
                    case let .failed(error):

                        Text(error.localizedDescription)
                    }
                }
                .navigationBarHidden(true)
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
    
    func MainList(members: [Member]) -> some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            let width: CGFloat = 100
            LazyVStack {
                ForEach((0..<GetRowNum(members: members)), id: \.self) { row in
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(0...2, id: \.self) { col in
                            if 3*row+col < members.count {
                                OnePerson(member: members[3*row+col], width: width)
                            } else {
                                Rectangle()
                                    .frame(width: width)
                            }
                        }
                    }
                }
            }
            .padding(.vertical, 4)
        }
    }
    
    func GetRowNum(members: [Member]) -> Int {
        let t = members.count / 3
        if members.count % 3 == 0 {
            return t
        } else {
            return t + 1
        }
    }
    
    func OnePerson(member: Member, width: CGFloat) -> some View {
        VStack(alignment: .center) {
            // MARK: Face Image
            AsyncImage(url: URL(string: member.img_url)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .frame(width: width, height: width)
            .aspectRatio(contentMode: .fill)
            .clipShape(Circle())
            .background(
                Circle()
                    .stroke(Color.purple, lineWidth: 4)
            )
            
            // MARK: Name
            Text(member.user_name)
                .foregroundColor(Color.purple)
                .padding(.vertical, 4)
        }
        .padding(2)
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
