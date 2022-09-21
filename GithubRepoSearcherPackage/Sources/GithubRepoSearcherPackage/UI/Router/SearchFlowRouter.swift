//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import SwiftUI

final class SearchFlowRouter: ObservableObject, FlowRouter {

    static let shared = SearchFlowRouter()

    @Published
    var navigationPath: NavigationPath = .init()

    private(set) var nextTransitionRoute: PushRoute = .unknown

    func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }

    func nextTransitionScreen() -> some View {
        nextTransitionRoute.view
    }

    func clearPath() {
        navigationPath = .init()
        nextTransitionRoute = .unknown
    }
}

extension SearchFlowRouter {
    enum PushRoute: Hashable {
        case unknown
        case detail(repo: GithubRepo)

        @ViewBuilder
        var view: some View {
            switch self {
            case .detail(let repo):
                DetailScreen(repo: repo)
            case .unknown:
                fatalError("no set next transition screen.")
            }
        }
    }
}
