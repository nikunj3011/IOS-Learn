//
//  HTMLStringView.swift
//  testSwiftUI
//
//  Created by Nikunj Rathod on 2025-08-24.
//


import SwiftUI
import WebKit

struct HTMLStringView: UIViewRepresentable {
    let htmlContent: String

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.loadHTMLString(htmlContent, baseURL: nil)
    }
}
