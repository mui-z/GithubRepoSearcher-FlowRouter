//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import Factory

protocol GithubRepoUseCase {
    func searchGithubRepos(keyword: String) async -> Result<[GithubRepo], WebAPIError>
    func getReadmeText(userName: String, repoName: String, defaultBranch: String) async -> Result<String, WebAPIError>
}

struct GithubRepoUseCaseImpl: GithubRepoUseCase {

    @Injected(Container.githubRepoGateway)
    private var gateway: GithubRepoGateway

    func searchGithubRepos(keyword: String) async -> Result<[GithubRepo], WebAPIError> {
        do {
            let repos = try await gateway.searchGithubRepo(searchKeyWord: keyword)
            return .success(repos)
        } catch {
            print(error.localizedDescription)
            return .failure(WebAPIError.notFoundError) // todo: error mapping
        }
    }

    func getReadmeText(userName: String, repoName: String, defaultBranch: String) async -> Result<String, WebAPIError> {
        do {
            let text = try await gateway.getReadmeMarkdownText(userName: userName, repoName: repoName, defaultBranch: defaultBranch)
            return .success(text)
        } catch {
            print(error.localizedDescription)
            return .failure(WebAPIError.notFoundError)
        }
    }
}
