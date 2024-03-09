//
//  ContentView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI

struct ContentView: View {
    @State var selection = 1// タブの選択項目を保持する
    @StateObject var logic = Logic()
    @State private var title: String = ""
    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                ZStack {
                    Color("TopBarColor")
                        .edgesIgnoringSafeArea(.top) // Safe Areaを無視
                    MapView(logics: logic)
                        .frame(maxWidth: .infinity, maxHeight: 640)
                        .offset(x: 0, y: 40)
                    SearchBar(logic: logic)
                        .offset(x: 0, y: -300)
                }  //
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1)
                ChatView()   // Viewファイル②
                    .tabItem {
                        FloatButton()
                    }
                    .tag(2)
            } // TabView ここまで
        }
        //戻るボタン色変更
        .accentColor(Color.white)
    }
}


//掲示板に飛ぶボタン
struct FloatButton: View {
    var body: some View {
        HStack { // --- 2
            NavigationLink(destination: ChatView()) {
                HStack {
                    Spacer()
                    Image(systemName: "bubble.left")
                    Text("掲示板")
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 18))
        }
        .frame(width: 110, height: 60)
        .background(Color.gray)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
        .offset(x: -125, y: -315)
    }
}

///////////////////////////////////////////RouteFinishButtonは道案内するときにだけ表示させたい
//経路案内終了ボタン
struct RouteFinishButton: View {
    var body: some View {
        HStack { // --- 2
            NavigationLink(destination: ContentView()) {
                HStack {
                    Spacer()
                    Image(systemName: "xmark.app")
                    Text("終了")
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 18))
        }
        .frame(width: 110, height: 60)
        .background(.blue)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
        .offset(x: -125, y: -240)
    }
}

#Preview {
    ContentView()
}
