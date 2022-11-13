//
//  SwiftUIView.swift
//  
//
//  Created by osushi on 2022/09/19.
//

import SwiftUI

struct ReadmeScreen: View {

    @StateObject
    var viewModel = ReadmeViewModel()

    @Environment(\.dismiss) private var dismiss

    let repo: GithubRepo

    let errorMsg =
        """
        Could not fetch.
        Please open in browser.
        """

    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
            } else {
                Text(viewModel.rawText)
                    .padding()
            }
        }
            .alert("Oops!", isPresented: $viewModel.showError, actions: {
                Button("OK", role: .cancel) {
                    dismiss()
                }
            }, message: {
                Text(errorMsg)
            })
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                    }
                }
            }
            .onAppear {
                viewModel.getRawText(repo: repo)
            }
    }
}
