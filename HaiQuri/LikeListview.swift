//
//  LikeListview.swift
//  HaiQuri
//
//  Created by 澤木柊斗 on 2024/03/11.
//

import SwiftUI
import CoreData

struct LikeListview: View {
    var logic: Logic
    //マップ情報取得
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.latitude, ascending: true)],
        animation: .default)
    private var entityList: FetchedResults<Entity>
    //追加
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        ZStack {
            Color("TopBarColor")
                .edgesIgnoringSafeArea(.all) // Safe Areaを無視
            List(entityList, id: \.placeName) { entity in
                VStack(alignment: .leading){
                    Text(entity.placeName ?? "")
                        .fontWeight(.bold)
                    Text(entity.title ?? "")
                    Text(entity.adress ?? "")
                        .font(.caption)
                }
            }
        }
    }
}
