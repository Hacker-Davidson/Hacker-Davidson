import SwiftUI
import CoreData



struct HalfSheetDetails: View {
    //マップ情報取得
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.latitude, ascending: true)],
        animation: .default)
    private var entityList: FetchedResults<Entity>
    //追加
    @Environment(\.managedObjectContext) private var viewContext
    //
    @Binding var show: Bool
    // before → @State private var id: String = ""
    @State var id: String // ← after
    @State var title: String
    @State var latitude: Double
    @State var longitude: Double
    @State var adress: String
    @State var placeName: String

    var body: some View {
        VStack {
            headerSection
            detailSection
                .padding(.bottom, 10)
            routeButton
                .padding(.top, 10)
        }
        .padding()
        .background(Color(UIColor.systemBackground))
        .padding(.horizontal, 10)
    }

    private var headerSection: some View {
        HStack {
            Spacer()
            Text(title)
                .font(.system(size: 25))
                .foregroundColor(.primary)
            Spacer()
            Button(action: {
                print("Toggle Like")
                addLike(title: title, latitude: latitude, longitude: longitude, adress: adress, mapID: id, placeName: placeName)
            }) {
                Image(systemName: checkIfAlreadyFavorited(id: id) ? "heart.fill" : "heart")
                    .foregroundColor(checkIfAlreadyFavorited(id: id) ? .red : .gray)
                    .font(.system(size: 25))
            }
            Spacer()
        }
        .padding(.top, 30)
    }


    private var detailSection: some View {
        VStack(spacing: 40) {
            Spacer()
            HStack {
                Spacer()
                Text("聖地名")
                    .font(.system(size: 20))
                Spacer()
                Text(placeName)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }

            HStack {
                Spacer()
                Text("聖地の住所")
                    .font(.system(size: 20))
                Spacer()
                Text(adress)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                Spacer()
            }
        }
    }

    private var routeButton: some View {
        Button(action: {
            print("経路案内")
        }) {
            HStack {
                Image(systemName: "location.fill")
                Text("経路")
                    .foregroundColor(.white)
            }
            .padding()
            .background(Color.customTopBarColor)
            .cornerRadius(15.0)
            .shadow(radius: 2)
        }
        .padding(.top, 50)
    }



    func addLike (title: String, latitude: Double, longitude: Double, adress: String, mapID: String, placeName: String){
        let entity = Entity(context: viewContext)
        entity.title = title
        entity.latitude = latitude
        entity.logitude = longitude
        entity.adress = adress
        entity.mapID = mapID
        entity.placeName = placeName
        entity.isFavorite = true
        try? viewContext.save()
        print("いいね機能🐈")
    }
    func confirmLikeList(id: String) {
        for entity in entityList {
            if entity.mapID == id {
                self.id = entity.mapID ?? ""
                title = entity.title ?? ""
                latitude = entity.latitude
                longitude = entity.logitude
                placeName = entity.placeName ?? ""
                adress =  entity.adress ?? ""
                print(self.id)
                print(self.title)
                print(self.latitude)
                print(self.adress)
                print(self.placeName)


            } else {
                print("残念でした")
            }
        }
    }

    // お気に入りがすでに登録されているか確認する関数


    func checkIfAlreadyFavorited(id: String) -> Bool {
        if let _ = entityList.first(where: { $0.mapID == id }) {
            // id が一致するエンティティが見つかった場合
            return true
        }
        return false
        // id が一致するエンティティが見つからない場合は何もしない（isFavorited はそのまま）
    }

}


