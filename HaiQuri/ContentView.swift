//
//  ContentView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {  // --- 1
                FloatButton()
            }
            .toolbar {
                customToolbarItems
            }
        }
        //戻るボタン色変更
        .accentColor(Color.red)
    }
}



struct FloatButton: View {
    var body: some View {
        HStack { // --- 2
            NavigationLink(destination: ContentView()) {
                HStack {
                    Spacer()
                    Image(systemName: "pencil")
                    Text("掲示板")
                    Spacer()
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 24))

        }
        .frame(width: 130, height: 60)
        .background(Color.customButtonColor)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
        .offset(x: 124, y: -90)
    }
}


//ToolBarカスタム
extension ContentView {
    var customToolbarItems: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            HStack {
                Text("aaaa           ")
                    .foregroundColor(.white)
                    .font(.system(size: 40))
                    .padding(.bottom, 20)
                Menu {
                    Button("ユーザー集", action: {
                        // 選択肢 1 のアクション
                    })
                    Button("ログアウト", action: {
                        // 選択肢 2 のアクション
                    })
                } label: {
                    Image(systemName: "list.bullet")
                }
            }

        }
    }

}

    #Preview {
        ContentView()
    }
