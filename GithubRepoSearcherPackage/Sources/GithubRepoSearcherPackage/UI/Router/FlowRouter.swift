//
// Created by osushi on 2022/09/20.
//

import Foundation
import SwiftUI

protocol FlowRouter: Hashable {
    associatedtype PushRoute: Hashable
    associatedtype NextScreen: View

    var id: UUID { get }

    var navigationPath: NavigationPath { get set }

    var nextTransitionRoute: PushRoute { get }

    func triggerScreenTransition(route: PushRoute)
    func nextTransitionScreen() -> NextScreen
}
