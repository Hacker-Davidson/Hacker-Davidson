//
//  HaiQuriApp.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI

@main
struct HaiQuriApp: App {
    init() {
        //NavigationBarの設定
               let appearance = UINavigationBarAppearance()
               appearance.configureWithOpaqueBackground()
               appearance.backgroundColor = .blue  // ナビゲーションバーの背景色
               appearance.titleTextAttributes = [.foregroundColor: UIColor.white]  // タイトルの色
               appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]  // 大きなタイトルの色

               // ナビゲーションバーとスクロールビューの間の透明な境界線を削除
               appearance.shadowColor = nil

               //Navigationbarの標準の外観にする
               UINavigationBar.appearance().standardAppearance = appearance
               //スクロールしたとき
               UINavigationBar.appearance().scrollEdgeAppearance = appearance
               //横向きの設定
               UINavigationBar.appearance().compactAppearance = appearance // For iPhone small navigation bar in landscape.
       }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
