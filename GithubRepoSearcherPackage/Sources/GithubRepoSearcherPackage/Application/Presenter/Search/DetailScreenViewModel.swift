//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/19.
//

import SwiftUI

class DetailScreenViewModel: ObservableObject {
    @Published
    var isMarkdownScreenPresent = false

    private var router: SearchFlowRouter

    init(router: SearchFlowRouter) {
        self.router = router
    }
}
