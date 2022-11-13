//
//  File.swift
//  
//
//  Created by osushi on 2022/09/18.
//

import Foundation
import SwiftUI

final class SearchFlowRouter: ObservableObject, FlowRouter, Hashable {
    static func ==(lhs: SearchFlowRouter, rhs: SearchFlowRouter) -> Bool {
        lhs.id == rhs.id
    }

    private let id = UUID().uuidString

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

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

extension SearchFlowRouter {
    enum PushRoute: Hashable {
        case unknown
        case detail(repo: GithubRepo, router: SearchFlowRouter)

        @ViewBuilder
        var view: some View {
            switch self {
            case .detail(let repo, let router):
                DetailScreen(repo: repo, router: router)
            case .unknown:
                fatalError("no set next transition screen.")
            }
        }
    }
}
