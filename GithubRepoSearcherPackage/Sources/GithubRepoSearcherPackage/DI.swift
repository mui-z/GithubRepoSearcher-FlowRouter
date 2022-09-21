//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import SwiftUI
import Factory

extension Container {
    static let githubRepoGateway = Factory { GithubRepoGatewayImpl() as GithubRepoGateway }
    static let githubRepoSearchUseCase = Factory { GithubRepoUseCaseImpl() as GithubRepoUseCase }
}
