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
    @State var inputText: String = ""
    @State var watchSearchBar: Bool = true // Mapの時true
    @State private var showImagePicker = false
    @State private var capturedImage: UIImage?
    @State var isShowCameracomfirm: Bool = false

    let animeTitleList: [String] = ["けいおん", "涼宮ハルヒの憂鬱", "ちはやふる", "東京喰種", "四月は君の嘘", "けものフレンズ", "月がきれい", "聲の形"]
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(Color.customTopBarColor)
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
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

                }
                .alert("目的地に近づきました", isPresented: $logic.isShowCam) {
                    Button("閉じる") {
                    
                    }
                    Button("カメラを開く") {
                        showImagePicker = true
                    }
                } message: {
                    VStack {
                        Text("写真を撮って思い出を残しましょう！")
                    }
                }
                //
                .tabItem {
                    Label("Map", systemImage: "map")
                }
                .tag(1)
                .onChange(of: selection) { newSelection in
                    // MapViewタブが選択されたときだけsearchbarを表示
                    watchSearchBar = newSelection == 1
                }
                ChatView()   // Viewファイル②
                    .tabItem {
                        FloatButton(watchSearchBar: $watchSearchBar)
                            .onTapGesture {
                                print("Before/ContentView/watchSearchBar\(watchSearchBar)")

                                watchSearchBar
                                    .toggle()
                                print("After/ContentView/watchSearchBar\(watchSearchBar)")

                            }
                    }
                    .tag(2)
                LikeListview(logic: logic)
                    .tabItem { Label("いいね", systemImage: "heart.fill") }
                    .tag(3)
            } // TabView ここまで
            .navigationBarItems(trailing: Button(action: {
                // アクション
            }) {
                if watchSearchBar {
                    SearchBar(inputText: $inputText, title: $title, logic: logic)
                        .offset(x: 0, y: 17)
                }
            })
        }
        .sheet(isPresented: $isShowCameracomfirm) {
                 ImagePickerView(isShown: $showImagePicker, capturedImage: $capturedImage)
             }
        //戻るボタン色変更
        .accentColor(Color.white)
    }
}


//掲示板に飛ぶボタン
struct FloatButton: View {
    @Binding var watchSearchBar: Bool

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
            .onTapGesture {
                watchSearchBar.toggle()
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
