//
//  WebView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI
import WebKit

//WebView
struct WebView: UIViewRepresentable {
    let loadUrl: URL = URL(string: "http://website0.php.xdomain.jp")!

    func makeUIView(context: Context) -> WKWebView {
        print("表示します")
        let webView = WKWebView()
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        let request = URLRequest(url: loadUrl)
        uiView.load(request)
    }
}

//じゅんちゃんの前作ったやつ(テスト用)
struct ChatView: View {
    var body: some View {
        WebView()
            .edgesIgnoringSafeArea(.all) // オプション: セーフエリアを無視して全画面で表示
    }
}
