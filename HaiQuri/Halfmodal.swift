import SwiftUI
import CoreData

struct HalfsheetView: View {
    //追加
    @State var isShowSheet = false
    @State var adress = "愛知県名古屋市東区星崎町5453"
    @State var title = "影の実力者になりたくて"
    @State var latitude = 0.0
    @State var longitude = 0.0
    @State var id = "123457" // このidは保存ずみ
    @State var placeName = "めっちゃすごい体育館"

    var body: some View {
        Button("シートを表示") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {
            // before → HalfSheetDetails(show: $isShowSheet)
            HalfSheetDetails(show: $isShowSheet, id: id, isFavorited: false, title: title, latitude: latitude, longitude: longitude, adress: adress, placeName: placeName) // ← after
                .presentationDetents([.medium])
        }
    }
}

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
    @State var isFavorited: Bool
    @State var title: String
    @State var latitude: Double
    @State var longitude: Double
    @State var adress: String
    @State var placeName: String

    var body: some View {
        ZStack {
            Button{
                           print("経路案内")
                       }label: {
                           NavigationLink(destination: ContentView()) {
                               HStack {
                                   Image(systemName: "location.fill")
                                   Text("経路")
                                       .font(.title)
                               }
                           }
                           .frame(width: 130, height: 60)
                           .foregroundColor(.white)
                           .background(Color.customButtonColor)
                           .cornerRadius(30.0)
                           .shadow(radius: 3)
                           .padding(.top, 150)
                       }
                       .onAppear{
                           checkIfAlreadyFavorited()
                           //idが一致しているかどうかを調べる
                       }
                       .frame(maxWidth: .infinity, maxHeight: .infinity)
                       .background(Color.white)
                       .offset(x: 0, y: 80)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Text(title)
                        .font(.title)
                    Spacer()
                    // いいねボタン
                    Button{
                        // ボタンがタップされたときに isFavorited の状態をトグルする
                        print("トグル変更")
                        isFavorited.toggle()
                        //押されたタイミングでデータ取得したい
                        addLike(title: title, latitude: latitude, longitude: longitude, adress: adress, mapID: id,placeName: placeName)
                    }label: {
                        // isFavorited の値に基づいて異なるアイコンを表示
                        Image(systemName: isFavorited ? "heart.fill" : "heart")
                            .font(.title)
                            .foregroundColor(isFavorited ? .red : .gray) // お気に入りの状態によって色も変更する
                    }
                    .offset(x: -10,y: 0)
                    Spacer()
                }
                .offset(x: 20, y:-150)
                VStack {
                    HStack {
                        Spacer()
                        Text("聖地名")
                            .font(.system(size: 22))
                        Spacer()
                        Text(placeName)
                            .font(.system(size: 21))
                        Spacer()
                    }
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.5))
                        .padding(.horizontal, 20)
                        .offset(x:0, y: -10)
                }
                .offset(x: 0,y: -90)

                VStack {
                    HStack {
                        Spacer()
                        Text("聖地の住所")
                            .font(.system(size: 22))
                        Spacer()
                        Text(adress)
                            .font(.system(size: 21))
                        Spacer()
                    }
                    Divider()
                        .frame(height: 1)
                        .background(Color.gray.opacity(0.5))
                        .padding(.horizontal, 20)
                        .offset(x:0, y: -10)
                }
                .offset(x: 0,y: -40)
            }
            .offset(x: 0, y: -80)
        }
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
                isFavorited = entity.isFavorite
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
                print(self.isFavorited)


            } else {
                print("残念でした")
            }
        }
    }

    // お気に入りがすでに登録されているか確認する関数
    func checkIfAlreadyFavorited() {
        if let _ = entityList.first(where: { $0.mapID == id }) {
            // id が一致するエンティティが見つかった場合
            self.isFavorited = true
            print(entityList)
        }
        // id が一致するエンティティが見つからない場合は何もしない（isFavorited はそのまま）
    }

}


#Preview ("ハーフモーダル"){
    HalfsheetView()
}
