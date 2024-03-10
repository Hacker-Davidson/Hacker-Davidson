import SwiftUI
import MapKit
import CoreData

struct HalfSheetDetails: View {
    //マップ情報取得
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Entity.latitude, ascending: true)],
        animation: .default)
    private var entityList: FetchedResults<Entity>

    //追加
    @Environment(\.managedObjectContext) private var viewContext
    @Binding var show: Bool
    @State var id: String
    @State var title: String
    @State var latitude: Double
    @State var longitude: Double
    @State var adress: String
    @State var placeName: String
    @Binding var isTapped: Bool
    var logic: Logic

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
                //                データ保存ロジック

                checkIfAlreadyFavorited(placeaName: placeName) ? deleteLiked(placeName: placeName): addLike(id: id, title: title, placeName: placeName, adress: adress, latitude: latitude, longitude: longitude)
            }) {
                Image(systemName: checkIfAlreadyFavorited(placeaName: placeName) ? "heart.fill" : "heart")
                    .foregroundColor(checkIfAlreadyFavorited(placeaName: placeName) ? .red : .gray)
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
            isTapped = true
            show = false
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
    func addLike(id: String, title: String, placeName: String, adress: String, latitude: Double, longitude: Double) {
        let context = Entity(context: viewContext)
        context.mapID = id
        context.title = title
        context.placeName = placeName
        context.adress = adress
        context.isFavorite = true
        context.latitude = latitude
        context.logitude = longitude
        try? viewContext.save()
        print("")
    }
    func checkIfAlreadyFavorited(placeaName: String) -> Bool {
        for index in 0..<entityList.count {
            if placeaName == entityList[index].placeName {
                print(entityList[index].placeName)
                print(placeaName)
                print("一致しました")
                return true
            }
        }
        return false
    }

    func deleteLiked(placeName: String){
        let context = Entity(context: viewContext)
        for entity in entityList {
            if entity.placeName == placeName {
                viewContext.delete(entity)
            }
            try? viewContext.save()
        }

    }
    // お気に入りがすでに登録されているか確認する関数
}


