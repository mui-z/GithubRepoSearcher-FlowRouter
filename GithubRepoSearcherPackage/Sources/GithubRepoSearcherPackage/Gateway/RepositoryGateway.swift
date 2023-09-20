//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation

protocol GithubRepoGateway {
    func searchGithubRepo(searchKeyWord: String) async throws -> [GithubRepo]
    func getReadmeMarkdownText(userName: String, repoName: String, defaultBranch: String) async throws -> String
}
