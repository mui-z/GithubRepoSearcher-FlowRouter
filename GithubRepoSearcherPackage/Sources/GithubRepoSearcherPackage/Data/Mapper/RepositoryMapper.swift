//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation

extension RepositorySearchResultRes {
    func toGithubRepos() -> [GithubRepo] {
        items.map { $0.toGithubRepo() }
    }
}

extension RepositoryRes {
    func toGithubRepo() -> GithubRepo {
        GithubRepo(id: nodeId, user: owner.toUser(), repoName: name, description: description ?? "No provided description.", url: htmlUrl, defaultBranch: defaultBranch)
    }
}

extension OwnerRes {
    func toUser() -> GithubUser {
        GithubUser(id: nodeId, name: login, avatarUrl: avatarUrl)
    }
}
