//
//  SearchBar.swift
//  HaiQuri
//
//  Created by 澤木柊斗 on 2024/03/08.
//

import SwiftUI

struct SearchBar: View {
    @State private var inputText = ""
    let logic: Logic
    var body: some View {
        HStack {
            TextField("", text: $inputText, prompt: Text("けいおん!")
                .foregroundColor(.gray))
            .frame(width: 270)
            .padding(.vertical, 10)
            .padding(.horizontal, 10)
            .background(.white)
            .cornerRadius(15)
            .padding(.horizontal, -10) // またはここを調整
            .foregroundColor(.black)
            .offset(x: -20, y: 0)
            .overlay {
                if !inputText.isEmpty {
                    Image(systemName: "xmark.circle")
                        .foregroundStyle(.gray)
                        .scaleEffect(1.4)
                        .padding(.leading, 300)
                        .offset(x: -50, y: 0)
                        .onTapGesture {
                            inputText = ""
                            UIApplication.shared.endEditing()
                        }
                }
            }
            Button(action: {
                logic.serchPlacesUsingAnimeTitle(title: inputText)
            }, label: {
                Text("検索")
                })
            }
            .offset(x: -20, y: -20)
    }
}

