//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/19.
//

import SwiftUI

class ReadmeFlowRouter: ObservableObject, FlowRouter {
    let id = UUID()

    @Published
    var navigationPath: NavigationPath = .init()

    private(set) var nextTransitionRoute: PushRoute = .unknown

    func triggerScreenTransition(route: PushRoute) {
    }

    func nextTransitionScreen() -> some View {
        Text("")
    }

    enum PushRoute: Hashable {
        case unknown
    }
}

extension ReadmeFlowRouter {
    static func ==(lhs: ReadmeFlowRouter, rhs: ReadmeFlowRouter) -> Bool {
        lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
