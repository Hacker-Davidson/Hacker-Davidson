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

        Button("シートを表示") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {

            HalfSheetDetails(show: $isShowSheet)
                .presentationDetents([.medium]) // ⬅︎
        }
    }
}

struct HalfSheetDetails: View {
    @Binding var show: Bool

    var body: some View {
        ZStack {
            Text("aaaaaa")
                .font(.title)

        }
    }
}


struct SecredPlaceName: View {
    var body: some View {
        ZStack {
            HStack {
                Text("聖地名")
                    .font(.system(size: 40))
                    .offset(x: -100,y: 0)
                Text("aaa")
            }
            Divider()
                .frame(width: 360,height: 20)
                .offset(x: 0,y: 30)
        }
    }
}

struct SecredAdress: View {
    var body: some View {
        ZStack {
            HStack {
                Text("聖地のある住所")
                    .font(.system(size: 40))
                    .offset(x: -100,y: 0)
                Text("aaaaaaa")
            }
            Divider()
                .frame(width: 360,height: 20)
                .offset(x: 0,y: 30)
        }
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
