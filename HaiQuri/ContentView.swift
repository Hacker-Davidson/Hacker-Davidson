//
//  ContentView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI

struct ContentView: View {
    @StateObject var logic = Logic()
    @State private var title: String = ""
    var body: some View {
        NavigationView {
            ZStack {  // --- 1

                MapView(logics: logic)
                    .sheet(isPresented: $logic.isShowSheet) {
                        // before → HalfSheetDetails(show: $isShowSheet)
                        HalfSheetDetails(
                            show: $logic.isShowSheet,
                            id: logic.modalInfo.id ,
                            title: logic.modalInfo.title ?? "",
                            latitude: logic.modalInfo.latitude,
                            longitude: logic.modalInfo.longitude,
                            adress: logic.modalInfo.adress,
                            placeName: logic.modalInfo.placeName ?? ""
                        ) // ← after
                            .presentationDetents([.medium])
                    }

                SearchBar(logic: logic)
                FloatButton()
                ///////////////////////////////////////////RouteFinishButtonは道案内するときにだけ表示させたい
                RouteFinishButton()
                
            }
            .toolbar {
                customToolbarItems
            }
            
        }
        //戻るボタン色変更
        .accentColor(Color.red)
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
        .background(Color.customButtonColor)
        .cornerRadius(30.0)
        .shadow(color: .gray, radius: 3, x: 3, y: 3)
        .padding(EdgeInsets(top: 0, leading: 0, bottom: 16.0, trailing: 16.0)) // --- 5
        .offset(x: -125, y: -315)
    }
}

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
