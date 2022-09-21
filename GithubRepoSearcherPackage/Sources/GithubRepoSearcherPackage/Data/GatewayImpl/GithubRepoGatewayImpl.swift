//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import Alamofire

struct GithubRepoGatewayImpl: GithubRepoGateway {

    func searchGithubRepo(searchKeyWord: String) async throws -> [GithubRepo] {
        let headers: HTTPHeaders = [
            .accept("application/vnd.github+json"),
            .authorization(bearerToken: "")
        ]
        let url = URL(string: "https://api.github.com/search/repositories?q=\(searchKeyWord)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!

        let result = await AF.request(url, headers: headers)
                             .serializingDecodable(RepositorySearchResultRes.self)
                             .result

        switch result {
        case .success(let repos):
            return repos.toGithubRepos()
        case .failure(let error):
            print(error.localizedDescription)
            throw WebAPIError.notFoundError
        }
    }

    func getReadmeMarkdownText(userName: String, repoName: String, defaultBranch: String) async throws -> String {
        let url = URL(string: "https://raw.githubusercontent.com/\(userName)/\(repoName)/\(defaultBranch)/README.md")!
        let result = await AF.request(url)
                             .validate()
                             .serializingString()
                             .result

        switch result {
        case .success(let str):
            return str
        case .failure(let error):
            print(error.localizedDescription)
            throw WebAPIError.notFoundError
        }
    }
}
