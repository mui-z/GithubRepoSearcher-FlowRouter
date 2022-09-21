//
//  File.swift
//  
//
//  Created by osushi on 2022/09/19.
//

import Foundation
import Factory

@MainActor
class ReadmeViewModel: ObservableObject {

    init() {
    }

    private var useCase = Container.githubRepoSearchUseCase()

    @Published
    var rawText: String = ""

    @Published
    var isLoading = false

    @Published
    var showError: Bool = false

    func getRawText(repo: GithubRepo) {
        Task {
            isLoading = true
            let result = await useCase.getReadmeText(userName: repo.user.name, repoName: repo.repoName, defaultBranch: repo.defaultBranch)
            switch result {
            case .success(let text):
                rawText = text
            case .failure(_):
                self.showError = true
            }
            isLoading = false
        }
    }
}
