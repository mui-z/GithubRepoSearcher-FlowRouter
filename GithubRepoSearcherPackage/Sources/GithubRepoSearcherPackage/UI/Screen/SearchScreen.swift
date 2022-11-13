//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/03/05.
//

import SwiftUI
import Factory

struct SearchScreen: View {

    @State var searchKeyword = ""
    @State var hasSearched = false

    @StateObject var viewModel: SearchScreenViewModel

    var router: SearchFlowRouter

    public init(router: SearchFlowRouter) {
        self.router = router
        self._viewModel = StateObject(wrappedValue: SearchScreenViewModel(router: router))
    }

    var body: some View {
        VStack {
            TextField("title", text: $searchKeyword)
                .onSubmit {
                    guard !searchKeyword.isEmpty else { return }

                    hasSearched = true
                    viewModel.searchRepos(keyword: searchKeyword)
                }
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
                .textFieldStyle(.roundedBorder)
                .submitLabel(.search)
                .padding()

            if (viewModel.isLoading) {
                Text("Loading...")
                ProgressView()
            } else if (viewModel.githubRepos.isEmpty) {
                emptyView
            } else {
                githubReposResultList
            }
            Spacer()
        }
            .navigationDestination(for: SearchFlowRouter.PushRoute.self) { _ in
                viewModel.nextScreen()
                         .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("Search")
    }

    var emptyView: some View {
        Text(hasSearched ? "\(viewModel.searchedKeyword): search result is empty :(" : "Let's Searching!")
    }

    var githubReposResultList: some View {
        List {
            ForEach(viewModel.githubRepos, id: \.self) { repo in
                HStack {
                    VStack(alignment: .leading) {
                        Text("\(repo.user.name)/\(repo.repoName)")
                            .font(.callout)
                            .fontWeight(.bold)
                            .padding(.bottom, 0.1)

                        Text(repo.description)
                            .font(.caption)
                    }

                    Spacer()

                    Image(systemName: "chevron.forward")
                        .foregroundColor(.gray)
                }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        viewModel.triggerTransition(route: .detail(repo: repo, router: router))
                    }
            }
        }
    }
}
