//
//  GithubRepo.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation

struct GithubRepo: Identifiable, Hashable {
    let id: String
    let user: GithubUser
    let repoName: String
    let `description`: String
    let url: String
    let defaultBranch: String
}

struct GithubUser: Identifiable, Hashable {
    let id: String
    let name: String
    let avatarUrl: String
}
