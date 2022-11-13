//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import SwiftUI

struct DetailScreen: View {

    let repo: GithubRepo

    @StateObject
    var readmeFlowRouter = ReadmeFlowRouter()

    @StateObject
    var viewModel: DetailScreenViewModel

    init(repo: GithubRepo, router: SearchFlowRouter) {
        self.repo = repo
        self._viewModel = StateObject(wrappedValue: DetailScreenViewModel(router: router))
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                AsyncImage(url: URL(string: repo.user.avatarUrl)!, content: { image in
                    image.resizable()
                }, placeholder: {
                    ProgressView()
                })
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)

                Text(repo.user.name)
                    .foregroundColor(.gray)
                    .padding(.horizontal, 10)
                    .padding(.vertical)

                Spacer()
            }

            Text(repo.repoName)
                .font(.title)
                .fontWeight(.bold)

            Text(repo.description)
                .font(.callout)

            Button("open README") {
                viewModel.isMarkdownScreenPresent = true
            }
                .padding(.vertical, 3)


            Spacer()
                .frame(height: 100)

            Link("Open in Github App.", destination: URL(string: repo.url)!)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding()

            Spacer()
        }
            .padding()
            .fullScreenCover(isPresented: $viewModel.isMarkdownScreenPresent, onDismiss: {
                viewModel.pop()
            }) {
                NavigationStack(path: $readmeFlowRouter.navigationPath) {
                    ReadmeScreen(repo: repo)
                        .navigationBarTitle("README.md")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
    }
}
