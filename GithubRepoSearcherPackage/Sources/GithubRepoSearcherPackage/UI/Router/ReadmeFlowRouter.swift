//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/19.
//

import SwiftUI

class ReadmeFlowRouter: ObservableObject, FlowRouter {

    static let shared = ReadmeFlowRouter()

    @Published
    var navigationPath: NavigationPath = .init()

    private(set) var nextTransitionRoute: PushRoute = .unknown

    func triggerScreenTransition(route: PushRoute) {
    }

    func nextTransitionScreen() -> some View {
        Text("")
    }

    func clearPath() {
        navigationPath = .init()
        nextTransitionRoute = .unknown
    }

    enum PushRoute: Hashable {
        case unknown
    }
}
