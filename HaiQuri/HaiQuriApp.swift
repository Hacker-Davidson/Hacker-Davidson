//
//  HaiQuriApp.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI

@main
struct HaiQuriApp: App {
    let presisitenceController = PersistenceController.shared
//    init() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//
//        // カスタムカラーをUIColorとして参照し、ナビゲーションバーの背景色に設定
//        if let backgroundColor = UIColor(named: "TopBarColor") {
//            appearance.backgroundColor = backgroundColor
//        }
//
//        // タイトルの色を白に設定
//        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
//        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//        // ナビゲーションバーの境界線を削除
//        appearance.shadowColor = nil
//
//        // 設定を適用
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, presisitenceController.container.viewContext)
        }
    }
}
