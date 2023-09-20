//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import SwiftUI

final class SearchFlowRouter: ObservableObject, FlowRouter {
    let id = UUID()

    @Published
    var navigationPath: NavigationPath = .init()

    private(set) var nextTransitionRoute: PushRoute = .unknown

    func triggerScreenTransition(route: PushRoute) {
        navigationPath.append(route)
        nextTransitionRoute = route
    }

    func nextTransitionScreen() -> some View {
        nextTransitionRoute.nextView(router: self)
    }
}

extension SearchFlowRouter {
    enum PushRoute: Hashable {
        case unknown
        case detail(repo: GithubRepo)

        func nextView(router: SearchFlowRouter) -> some View {
            switch self {
            case .detail(let repo):
                return DetailScreen(repo: repo, router: router)
            case .unknown:
                fatalError("no set next transition screen.")
            }
        }
    }
}
