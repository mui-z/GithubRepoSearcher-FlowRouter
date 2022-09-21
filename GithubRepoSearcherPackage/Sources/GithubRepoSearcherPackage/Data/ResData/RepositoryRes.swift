//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation

struct RepositorySearchResultRes: Decodable {
    let items: [RepositoryRes]
}

struct RepositoryRes: Decodable {
    let nodeId: String
    let name: String
    let owner: OwnerRes
    var `description`: String?
    let htmlUrl: String
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case nodeId = "node_id"
        case name
        case owner
        case `description`
        case htmlUrl = "html_url"
        case defaultBranch = "default_branch"
    }
}

struct OwnerRes: Decodable {
    let nodeId: String
    let login: String
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case nodeId = "node_id"
        case login
        case avatarUrl = "avatar_url"
    }
}
