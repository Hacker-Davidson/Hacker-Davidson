//
//  ContentView.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @State var selection = 1// タブの選択項目を保持する
    @StateObject var logic = Logic()
    @State private var title: String = ""
    @State private var mapView: MKMapView?
    @State private var isTapped: Bool = false
    @State private var isDelegate: Bool = false

    var body: some View {
        NavigationView {
            TabView(selection: $selection) {
                ZStack {
                    Color("TopBarColor")
                        .edgesIgnoringSafeArea(.all) // Safe Areaを無視
                    MapView(logics: logic, isTapped: $isTapped)
                        .sheet(isPresented: $logic.isShowSheet) {
                            // before → HalfSheetDetails(show: $isShowSheet)
                            HalfSheetDetails(
                                show: $logic.isShowSheet,
                                id: logic.modalInfo.id ,
                                title: logic.modalInfo.title ,
                                latitude: logic.modalInfo.latitude,
                                longitude: logic.modalInfo.longitude,
                                adress: logic.modalInfo.adress,
                                placeName: logic.modalInfo.placeName, isTapped: $isTapped, logic: logic
                            )
                            .presentationDetents([.half])
                        }
                        .frame(maxWidth: .infinity, maxHeight: 660)
                        .offset(x: 0, y: 0)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(0..<animeTitleList.count){ index in
                                    Button {
                                        inputText = animeTitleList[index]
                                    } label: {
                                        Text(animeTitleList[index])
                                            .foregroundStyle(.black)
                                            .fontWeight(.bold)
                                            .padding(.horizontal, 20)
                                            .padding(.vertical, 12)
                                            .background(.white)
                                            .cornerRadius(25)

                                }
                            }
                                .shadow(radius: 10)
                        }
                    }
                        .padding(.bottom, 550)

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
            .navigationBarItems(trailing: Button(action: {
                // アクション
            }) {
                SearchBar(logic: logic)
                    .offset(x: 0, y: 17)
            })
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




// シート幅のカスタム指定をextensionで管理
extension PresentationDetent {
    static let half = Self.fraction(0.43)
}
