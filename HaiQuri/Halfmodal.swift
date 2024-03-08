//
//  Halfmodal.swift
//  HaiQuri
//
//  Created by 櫻井絵理香 on 2024/03/08.
//

import SwiftUI
// ハーフシートモーダルの実装



struct HalfsheetView: View {

    @State private var isShowSheet = false

    var body: some View {
//モーダルを表示するためのボタン
        Button("シートを表示") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {

            HalfSheetDetails(show: $isShowSheet)
                .presentationDetents([.medium]) // ⬅︎
        }
    }
}

//モーダル詳細ページ
struct HalfSheetDetails: View {
    @Binding var show: Bool

    var body: some View {
        ZStack {
            Text("aaaaaa")
            .offset(x: 0, y: -150)
            .font(.title)
            SecredPlaceName()
                .offset(x: 0, y: -70)
            SecredAdress()
                .offset(x: 16, y: 40)
            RouteButton()
                .offset(x: -119, y: 250)

        }
    }
}

//聖地名のテキスト
struct SecredPlaceName: View {
    var body: some View {
        ZStack {
            HStack {
                Text("聖地名")
                    .font(.system(size: 24))
                    .offset(x: -100,y: 0)
                Text("aaaaaaaaaa")
            }
            Divider()
                .frame(width: 360,height: 20)
                .offset(x: 0,y: 30)
        }
    }
}

//聖地の住所のテキスト
struct SecredAdress: View {
    var body: some View {
        ZStack {
            HStack {
                Text("聖地のある住所")
                    .font(.system(size: 20))
                    .offset(x: -80,y: 0)
                Text("aaaaaaa")
            }
            Divider()
                .frame(width: 360,height: 20)
                .offset(x: -10,y: 30)
        }
    }
}

//経路ボタン->押したら経路案内する
struct RouteButton: View {
    var body: some View {
        HStack { // --- 2
            NavigationLink(destination: ContentView()) {
                HStack {
                    Spacer()
                    Image(systemName: "pencil")
                    Text("経路")
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

#Preview("モーダル全体") {
    HalfsheetView()
}

#Preview ("文字の方"){
    SecredPlaceName()
}

#Preview () {
    SecredAdress()
}
