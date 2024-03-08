//
//  WebView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let loadUrl: URL

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: loadUrl)
        uiView.load(request)
    }
}

struct ChatView: View {
    var body: some View {
        WebView(loadUrl: URL(string: "http://website0.php.xdomain.jp/")!)
            .edgesIgnoringSafeArea(.all) // オプション: セーフエリアを無視して全画面で表示
    }
}
