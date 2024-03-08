import SwiftUI

struct HalfsheetView: View {
    @State private var isShowSheet = false

    var body: some View {
        Button("シートを表示") {
            isShowSheet.toggle()
        }
        .sheet(isPresented: $isShowSheet) {
            HalfSheetDetails(show: $isShowSheet)
                .presentationDetents([.medium])
        }
    }
}

struct HalfSheetDetails: View {
    @Binding var show: Bool

    var body: some View {
        VStack {
            Text("作品タイトル")
                .font(.title)
                .padding(.top, 20)

            SecredPlaceName()
                .offset(x: 0, y: 135)
            SecredAdress()
            RouteButton()
                .padding(.top, 150)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
    }
}

struct SecredPlaceName: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Spacer()
                Text("聖地名  ")
                    .font(.system(size: 21))
                Text("生田駅北口")
                Spacer()
            }

            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.5))
                .padding(.vertical, 4)
        }
        .padding(.horizontal)
    }
}

struct SecredAdress: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Spacer()
                Text("聖地の住所")
                    .font(.system(size: 20))
                Text("神奈川県川崎市多摩区生田7-8-4")
                Spacer()
            }

            Divider()
                .frame(height: 1)
                .background(Color.gray.opacity(0.5))
                .padding(.vertical, 4)
        }
        .padding(.horizontal)
    }
}

struct RouteButton: View {
    var body: some View {
        NavigationLink(destination: ContentView()) {
            HStack {
                Image(systemName: "location.fill")
                Text("経路")
                    .font(.title)
            }
            .frame(width: 130, height: 60)
            .foregroundColor(.white)
            .background(Color.customButtonColor)
            .cornerRadius(30.0)
            .shadow(radius: 3)
        }
    }
}

#Preview {
    HalfsheetView()
}
