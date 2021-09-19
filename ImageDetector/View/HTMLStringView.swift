//
//  HTMLStringView.swift
//  ImageDetector
//
//  Created by Marutharaj K on 17/09/21.
//

import WebKit
import SwiftUI

// MARK: - Type - HTMLStringView -

/**
 HTMLStringView will display feed description
 */
struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.sizeToFit()
        webView.isOpaque = false
        webView.backgroundColor = .darkModeBgColor
        webView.scrollView.backgroundColor = .darkModeBgColor
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
