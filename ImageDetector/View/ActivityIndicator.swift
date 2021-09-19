//
//  ActivityIndicator.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import SwiftUI

// MARK: - Type - ActivityIndicator -

/**
 ActivityIndicator will display loading indicator when app perform long running task
 */
struct ActivityIndicator: UIViewRepresentable {

    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style

    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }

    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}
